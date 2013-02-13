==================================================
==================================================
== How to: Use the Oozie Shell and Java Actions ==
==================================================
==================================================
Blog Post: http://TODO



==========================
= Building the Java Code =
==========================
The Java code used in the Java action is located in the Earthquake-J folder and is a standard maven project.

1) cd to Earthquake-J
2) Run 'mvn package to generate target/Earthquake-J-1.0-SNAPSHOT.jar'


==========================
= Preparing the Workflow =
==========================
The Oozie Workflow is located in the Earthquake-WF folder.

1) After building it, copy the Earthquake-J-1.0-SNAPSHOT.jar file to the Earthquake-WF/lib/ folder (this allows the WF to find the JAR)
2) Upload the Earthquake-WF folder somewhere in HDFS (e.g. /user/${user.name}/Earthquake-WF)
3) Open job.properties and adjust the various properties as necessary; these four in particular:
    oozie.wf.application.path (should point to where you uploaded Earthquake-WF)
    dataInputDir (should point to where you want the data downloaded to)
    outputDir (should point to where you want the processed output data)
    earthquakeMinThreshold (the minimum earthquake magnitude to use)


==================
= Running the WF =
==================
You can now create a Coordinator job to run the workflow every hour.  If you'd like to test it out by running the Workflow directly
you can follow these instructions (from the Earthquake folder):
1) Run 'hadoop fs -put Earthquake-WF Earthquake-WF'
2) Run 'oozie job -config Earthquake-WF/job.properties -run -oozie http://some.hostname:11000/oozie'
