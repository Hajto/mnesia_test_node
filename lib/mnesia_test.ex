defmodule MnesiaTest do
  use Application

  def start(_,_) do
    :inet_res.lookup(System.get_env("APP_NAME"),:in,:a)
    |> Enum.each(fn {a,b,c,d} ->
      IO.inspect Node.connect( :"#{System.get_env("MY_POD_NAMESPACE")}@#{a}.#{b}.#{c}.#{d}" ) #<- connect
    end)
    Task.Supervisor.start_link() #Just to stahp the sys
  end
end
