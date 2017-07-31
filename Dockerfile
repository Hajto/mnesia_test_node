FROM elixir:1.4.5
COPY . /
RUN mix compile
CMD echo "Application started" &&  elixir --name $MY_POD_NAMESPACE@$MY_POD_IP --no-halt --cookie $ERLANG_COOKIE -S mix run