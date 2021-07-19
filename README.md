# Coder Workshop: Repository

This repository is an example of a simple NodeJS web application. Coder provides some sample images, such as [this NodeJS ubuntu image](https://github.com/cdr/enterprise-images/blob/master/images/node/Dockerfile.ubuntu). 

# Workshop instructions

Test GPG signing of commits. No important stuff.
Adding another note. 


## Use the Coder workspace

During the workshop, we're going to walk through the following:

1.  Use the button to create an environment
    - Any name you want
    - Image Source is pre-filled with one for Node and Docker
    - Check "Run as Container-based Virtual Machine" option for Docker capabilities later
    - Leave resources alone for now, increasing them may prevent the pod from scheduling
2.  Review interface, build log, resource pool, etc
3.  Open VS Code in the browser to do some light development
4.  Set theme to dark
5.  Open the coder-react folder (note that many repos can be pulled into one workspace)
    - Notice it will ask to install recommended extensions
    - Restart the VS Code and it will show a "Start CodeTour" alert
6.  Open a terminal, run `yarn && yarn start` 
7.  See it build and run the app on port 3000
8.  Create a DevURL with the `+` or by running `coder urls create $CODER_ENVIRONMENT_NAME 3000 --access org --name $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)` 
9.  Notice the DevURL status is green, open the DevURL in a browser
10.  Make a change to the `src/App.js` file and witness the live reload
11.  Kill the yarn terminal with `ctrl-c`

#### Docker part

12.  `docker build -t nodeapp:local`
13.  `docker run -p 3000:3000 nodeapp:local`
14.  Make changes to the app, requires rebuilding the docker container
15.  Can run a service such as postgres
    - make a network `docker network create pgnet`
    - daemon mode `docker run -p 5432:5432 --net pgnet --name pg -e POSTGRES_PASSWORD=mysecretpassword -d postgres`
    - interactive mode `docker run -it --net pgnet --rm postgres psql -h pg -U postgres`
    - enter password `mysecretpassword` and then run querys. `\l` lists the databases.

## The workspace image

As mentioned above, the workspace image is generic amd can be used with Node JS app development. It can also be hsed as a "FROM" in another Dockerfile to add more tools such as kubectl or and terraform. 

Coder distributes many images that are optimized for the more trusted use cases. These images have sudo access, can run docker images, can install additional dependencies, and assume the internet is present and fully accessible. 

Your org could make a similar set of approved images from a hardened base image. If the image doesn't have sudo or run docker, the developers will not be able to add new software without completing the container modification process.  This process can be easy such as:

1.  Submit a pull/merge request to a repo
2.  Approver merges the branch to master which builds the new image
3.  The pipeline will validate that the rules were followed and allows access to the new image
4.  Coder sees the image tag update and prompts users to rebuild their environments to gain the new capabilities
5.  If there's a problem, they can roll back. 

## Security leverage points

1.  Kubernetes surrounding VPC or network segment, isolate it from the enterprise
2.  Pod and network security policies in the cluster
3.  Only imported images can create workspaces
4.  SDLC scanning tools apply to dev images 
5.  Visibility into developer tools and workflow


