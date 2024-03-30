# TinyNote - A Phoenix/Livebook/Docker Demo

This repo is a demonstration of running [livebook](https://livebook.dev)
alongside a [phoenix](https://www.phoenixframework.org/) app in
[docker](https://www.docker.com/).

We can then use livebook to run code on the phoenix server.

![a screenshot of livebook](./assets/lead-screenshot.png)

## Setup

- Run `docker-compose up`
- Open [http://localhost:4000/users/register] and create an account
- Open [http://localhost:4000/notes] and create a few notes
- Look in the logs for the livebook container to find the livebook URL
  (`docker-compose logs -f livebook`)
- Open the livebook URL
- Click "Open" in the top-right, and select `example-notebook.livemd`
- From a notebook, you can run code in the phoenix node, like
`TinyNote.Accounts.get_user!(1)`

## How it works

In `docker-compose.yml`, we define three services:

- `postgres`: the postgres database the app will use
- `tiny_note`: the phoenix application
- `livebook`: an instance of livebook

`tiny_note` is started through the `start-dev.sh` script, which sets the erlang
node name (`--name`) and the secret cookie (`--cookie`).

`livebook` is configured to use `tiny_note` as it's default runtime, via the
`LIVEBOOK_DEFAULT_RUNTIME` env-var. The value takes the form of
`attached:{node-name}:{cookie}`, where `{node-name}` and `{cookie}` must match
the values we set in `start-dev.sh`.

In addition, the `livebook/` directory is mounted into the `livebook` container,
so we can persist notebook files.

When we open the livebook UI and evaluate some code, it is actually evaluated
in the phoenix app node, so we have access to all the modules of our app, and
can access the database via ecto.
