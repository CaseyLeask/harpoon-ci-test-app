# harpoon-ci-test-app

This example app shows you how to add a `harpoon.yml` file to your project so you can test it in your build/CI pipeline using [harpoon-buildbox-agent](https://github.com/toolmantim/harpoon-buildbox-agent).

The [harpoon.yml](harpoon.yml) defines the entire environment for your app. For this app it's:

```yml
app:
  build: .
  links:
    - db:db
  environment:
    PGHOST: db
    PGUSER: postgres
db:
  image: postgres
```

* `app` is built from the [Dockerfile](Dockerfile) and is just an Ubuntu image with the postgresql client installed.
* `db` is just the [standard Postgresql server image](https://registry.hub.docker.com/_/postgres/), and is linked to `app` using the alias `db`.
* The environment variables tell the tests where it can find the linked Postgresql server.

Your harpoon.yml for buildbox is exactly the same one you'd use with harpoon for local development, but **the container containing your test scripts must be called app**. `app` is where harpoon-buildbox-agent will try to run your tests from inside of (using `harpoon run app <build-script>`).

See the [harpoon documentation](http://www.harpoon.sh/) for example conharpoonurations for various langauges and frameworks, as well [the harpoon.yml options](http://www.harpoon.sh/yml.html).

See [harpoon-buildbox-agent](https://github.com/toolmantim/harpoon-buildbox-agent) for how to run your Docker-enabled application in your Buildbox build pipeline.

## Using

* Add this repository as a new project in your Buildbox account

* Conharpoonure the build pipeline to have two parallel steps for `script/tests_1` and `script/tests_2`:

![image](https://cloud.githubusercontent.com/assets/153/4101094/a0b6faee-30d0-11e4-922d-0eca094b9488.png)

* Set your project's build agent query rules to only use `harpoon=true` build agents.
* Create the project.
* Start two or more harpoon-buildbox-agent instances.
* Trigger a build.
* Bask in the glory of parallel, isolated, Docker-enabled builds:

![image](https://cloud.githubusercontent.com/assets/153/4101405/5cc2f4ce-30e8-11e4-9ebd-d27898c1fdcf.gif)
