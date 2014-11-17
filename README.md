JON - V
==========================

Single Page Application to display JBoss Operation Network data in a visual way.

### First time

`npm install`

`bower install`


### Building

`brunch build`

You can also decide to automatically build everytime you cahnge a file by running `brunch watch` instead.

### Start

First you will need to create a htaccess file for the basic authentication process of the Mock API.
To do this create a file name `users.htpasswd` in the `mocks` folder.
The content of the file must be a series of `<user>:<password>` pairs.
e.g.
```
test:test
myUser:MyPassword
```
These will define the user credentials to access the application. 

Rember that while developing the application you should use the JON Mock API provided.
Update instructions will be provided here to set up the application for a production environment.

Start the mock API from the `mocks` folder by running `coffee jonMockApi.coffee`

Then start the application server from the root folder by running `coffee server.coffee`

then open your browser at `http://localhost:3333` and input any of the credentials you've set up in the `users.htpasswd` file.

### Unit Tests

Build the application and then run `npm test`




