defmodule MnesiaTest do
  use Application

  def start(_,_) do
    :inet_res.lookup('localhost',:in,:a)
    |> Enum.each(fn {a,b,c,d} ->
      IO.inspect Node.connect( :"#{System.get_env("MY_POD_NAMESPACE")}@#{a}.#{b}.#{c}.#{d}" ) #<- connect
    end)
    :ok
  end
end
