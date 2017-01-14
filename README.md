Thyme: dispatch jobs using RabbitMQ
===================================

Thyme is a set of Python scripts that use RabbitMQ as intermediary for
submitting and running jobs.

* Jobs are submitted to RabbitMQ using the `condor_submit` command.
* The `thyme_worker` command fetches one job from RabbitMQ, executes it and
  exits.


Condor-like interface for AliEn
-------------------------------

AliEn is the Grid middleware in use by the [ALICE](http://alice.cern.ch/)
experiment at [CERN](http://home.cern). It works by continuously submitting
pilot jobs on your local batch system: when pilots run they connect to the AliEn
central services to fetch the actual job.

AliEn features different connectors to communicate with a variety of batch
systems. Thyme piggybacks on the HTCondor interface: the shipped `condor_q` and
`condor_submit` commands behave the way AliEn expects them to do. It is
therefore possible to use Thyme on a site configured as HTCondor without
modifying AliEn's code.


Made for pilot jobs
-------------------

The Thyme worker was specifically designed to run pilot jobs inside one-time
containers at scale. Scalability is provided by RabbitMQ. Thyme does not perform
any cleanup of the working area as it assumes that somebody else (like Docker)
will take care of it.

As a matter of fact Thyme was designed to be run in containers spawned by
[Plancton](https://github.com/mconcas/plancton).

Thyme is fully stateless. Jobs in the queue might be lost and no recovery option
is available. Once a job is fetched from the queue it is gone, and there is no
way to know how many jobs were fetched and are running. Those features are
typical of batch systems and were not implemented as we do not need them in many
cases (such as AliEn).


Try it locally
--------------

You can try it locally with Docker Compose. Bring up the cluster:

    docker-compose up

You can submit jobs with:

    docker-compose scale condor_submit=<N>

where `<N>` is the number of jobs to submit. You can scale the workers (the ones
fetching and running the jobs) by using:

    docker-compose scale worker=<N>
