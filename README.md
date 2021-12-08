# Project 3: Understanding User Behavior
# Check out how to run our project in [this](project_3_notebook.ipynb) notebook!

- You're a data scientist at a game development company  

- Your latest mobile game has two events you're interested in tracking: `buy a
  sword` & `join guild`

- Each has metadata characterstic of such events (i.e., sword type, guild name,
  etc)


## Tasks

- Instrument your API server to log events to Kafka

-- This "API" is our Python Flask Framework.  
-- Expand this to include query string parameters.  

- Assemble a data pipeline to catch these events: use Spark streaming to filter
  select event types from Kafka, land them into HDFS/parquet to make them
  available for analysis using Presto. 
  
-- We have not yet covered presto.

-- Perhaps use Redis to store state.

-- Redis would potentially exist on its own.  Spark would talk to that.

-- Storing session state.  -- Flush cache when done.

-- Hive table / REDIS for summary data.

https://www.infoworld.com/article/3131058/analytics/big-data-face-off-spark-vs-impala-vs-hive-vs-presto.html
Presto:
http://prestodb.github.io/
https://prestodb.io/docs/current/

- Use Apache Bench to generate test data for your pipeline.

-- hit our endpoints with data for our API (python flask file) with different NVP stuff.

"sword types" "guild name"

- Produce an analytics report where you provide a description of your pipeline
  and some basic analysis of the events. Explaining the pipeline is key for this project!

-- Some kind of a jyputer notebook or documentation to.

-- to be able to re-create the pipeline from scratch   
-- as well as generate the events  
-- as well as generate reports off of the REDIS cache and / or the hive tables.  


- Submit your work as a git PR as usual. AFTER you have received feedback you have to merge 
  the branch yourself and answer to the feedback in a comment. Your grade will not be 
  complete unless this is done!

Use a notebook to present your queries and findings. Remember that this
notebook should be appropriate for presentation to someone else in your
business who needs to act on your recommendations. 

It's understood that events in this pipeline are _generated_ events which make
them hard to connect to _actual_ business decisions.  However, we'd like
students to demonstrate an ability to plumb this pipeline end-to-end, which
includes initially generating test data as well as submitting a notebook-based
report of at least simple event analytics. That said the analytics will only be a small
part of the notebook. The whole report is the presentation and explanation of your pipeline 
plus the analysis!


## Options

There are plenty of advanced options for this project.  Here are some ways to
take your project further than just the basics we'll cover in class:

- Generate and filter more types of events.  There are plenty of other things
  you might capture events for during gameplay

- Enhance the API to use additional http verbs such as `POST` or `DELETE` as
  well as additionally accept _parameters_ for events (e.g., purchase events
  might accept sword or item type)
  
-- everything that the user has bought.
-- endpoint in the API that allows pull of all items purchased by user.
-- the above presupposes the creation of a user that will be passed into endpoints as a paramter.

- Connect a user-keyed storage engine such as Redis or Cassandra up to Spark so
  you can track user state during gameplay (e.g., user's inventory or health)
  
-- > provide an edpoint API to extract reports / status.  

-- > Redis is being used by application layer.  

-- > What is being persisted to HDFS.  

-- > USE HDFS to show what is being purchased when etc. ..  


Parts of the pipeline.

--> Infrstructure: -- >YML  

--> End point -- This dirvies what events and pameterized events are available -- Python  Flask API. -- writing to potentially both redis and kafka.  

--> Event Generation -- Bench or Just Python.  
    -- "pitching" URLS against our flask container with buy events keyed by sword types, guild names, dates, and userids.  
     
Spark Job:  

-- > read the kafka events which came out of the event generator through the API.  
-- > Reports out of Hive for back-end analytics.  
-- > Game status dumps out of redis.  

Finally Presenting:  

How the pipeline is glued together.  
descritpion of events and event parameters / entities behind them. -- User being one. -- Purchases, others.  

[ ] -- Professional looking notebooks.


  
  
NEXT QUESTIONS: 

[ ] -- Who would like to start on what?  
[ ] -- YML: Ben --  
[ ] -- Event Generator/Pitcher: -- Ben
        event_generator_sample.txt
[ ] -- API Enpoint: -- Captures Events -- Python writing to Kafka and writing redis. -- Theresa.  
[ ] -- Spark-Submit -- reading from Kafka and persisting to HDFS. -- Don  
[ ] -- Back-end Hive Reporting: -- Aastha  
[ ] -- Redis Extraction: -- Ben  
[ ] -- When do we meet again?  -- Weekly initially. --   Saturday Afternoon 1 P.M.   
[ ] -- What do each of us bring to our next meeting? --    
[ ] -- Who is taking point on the next meeting?  --  Saturday Nov 6 Lise
[ ] -- Define event types.

Publish: 

user
sword_type  
guild_name  
purchase_time  
purchase_region  
  
  
  
  
  
  
---

#### GitHub Procedures

Important:  In w205, please never merge your assignment branch to the master branch. 

Using the git command line: clone down the repo, leave the master branch untouched, create an assignment branch, and move to that branch:
- Open a linux command line to your virtual machine and be sure you are logged in as jupyter.
- Create a ~/w205 directory if it does not already exist `mkdir ~/w205`
- Change directory into the ~/w205 directory `cd ~/w205`
- Clone down your repo `git clone <https url for your repo>`
- Change directory into the repo `cd <repo name>`
- Create an assignment branch `git branch assignment`
- Checkout the assignment branch `git checkout assignment`

The previous steps only need to be done once.  Once you your clone is on the assignment branch it will remain on that branch unless you checkout another branch.

The project workflow follows this pattern, which may be repeated as many times as needed.  In fact it's best to do this frequently as it saves your work into GitHub in case your virtual machine becomes corrupt:
- Make changes to existing files as needed.
- Add new files as needed
- Stage modified files `git add <filename>`
- Commit staged files `git commit -m "<meaningful comment about your changes>"`
- Push the commit on your assignment branch from your clone to GitHub `git push origin assignment`

Once you are done, go to the GitHub web interface and create a pull request comparing the assignment branch to the master branch.  Add your instructor, and only your instructor, as the reviewer.  The date and time stamp of the pull request is considered the submission time for late penalties. 

If you decide to make more changes after you have created a pull request, you can simply close the pull request (without merge!), make more changes, stage, commit, push, and create a final pull request when you are done.  Note that the last data and time stamp of the last pull request will be considered the submission time for late penalties.

Make sure you receive the emails related to your repository! Your project feedback will be given as comment on the pull request. When you receive the feedback, you can address problems or simply comment that you have read the feedback. 
AFTER receiving and answering the feedback, merge you PR to master. Your project only counts as complete once this is done.
