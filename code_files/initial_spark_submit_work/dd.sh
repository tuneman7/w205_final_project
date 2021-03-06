#mkdir ~/w205/spark-from-files/
#cd ~/w205/spark-from-files
#cp ~/w205/course-content/11-Storing-Data-III/docker-compose.yml .
# cp ~/w205/course-content/11-Storing-Data-III/*.py .
#bring up images
docker-compose up -d
echo "sleeping 25"
sleep 25
echo "looking at HDFS"

#look at hdf
docker-compose exec cloudera hadoop fs -ls /tmp/

echo "creating topic"

docker-compose exec kafka kafka-topics --create --topic events --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
sleep 3
docker-compose exec kafka kafka-topics --create --topic event_parameters --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
echo "sleeping"
sleep 4
rm log_file1.txt
echo " ">log_file1.txt

#spin up API endpoint flask container.
docker-compose exec mids env FLASK_APP=/w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/game_api.py flask run >> log_file1.txt &
echo "sleeping"
sleep 4
echo "copying config files over"
echo "docker-compose exec spark bash -c \"cp /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/log4j.properties ./conf/log4j.properties\""
docker-compose exec spark bash -c "cp /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/log4j.properties ./conf/log4j.properties"


echo "doing the spark submit"
echo "docker-compose exec spark spark-submit /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/separate_events_stream_2.py"

docker-compose exec spark spark-submit /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/separate_events_stream_2.py &

#create hive tables
echo "docker-compose exec cloudera hive -f /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/hive_table_creation.hql"
docker-compose exec cloudera hive -f /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/hive_table_creation.hql 


docker-compose exec cloudera hadoop fs -ls /tmp/


#echo "Run primative event pitcher/generator primative_event_pitcher.py"
echo "python primative_event_pitcher_ab.py > log_event_pitcher.txt"
echo "press and HOLD CTL+C to terminate:"
x=1
while [ $x -le 500 ]
do
  python primative_event_pitcher_ab_2.py >> log_event_pitcher.txt
  docker-compose exec mids curl http://localhost:5000/shutdown
  docker-compose exec mids env FLASK_APP=/w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/game_api.py flask run >> log_file1.txt &
  docker-compose exec presto presto --server presto:8080 --catalog hive --schema default -f /w205/project_3_team_2_tue_6_30/code_files/initial_spark_submit_work/query_hive_tables.hql 
  sleep 2
  echo "press and HOLD CTL+C to terminate:"
done

#python primative_event_pitcher.py  > log_event_pitcher.txt


#docker-compose down



