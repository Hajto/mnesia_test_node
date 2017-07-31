defmodule MnesiaTest do
  use Application

  def start(_,_) do
    :timer.sleep(5000);
    :inet_res.lookup(System.get_env("APP_NAME")<>".default.svc.cluster.local" |> IO.inspect,:in,:a)
    |> IO.inspect
    |> Enum.each(fn {a,b,c,d} ->
      IO.inspect Node.connect( :"#{System.get_env("MY_POD_NAMESPACE")}@#{a}.#{b}.#{c}.#{d}" ) #<- connect
    end)
    Task.Supervisor.start_link() #Just to stahp the sys
  end
end
