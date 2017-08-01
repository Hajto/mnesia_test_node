defmodule MnesiaTest do
  use Application

  def start(_,_) do
    spawn(&receiver/0)
    Task.Supervisor.start_link() #Just to stahp the sys
  end

  def extract_ip_list({:ok,{:dns_rec, _head, _query, list_rr, _, _}}) do
    Enum.map(list_rr, fn {:dns_rr, _link, _class, _type , _ ,_ , ip ,_undefined , _array ,_bool} -> ip end)
  end

  def receiver do
    send(self(), :ping)
    receive do
      _ ->
        IO.inspect Node.list()
        :timer.sleep(5000)
        receiver()
    end
  end

  def connect do

    try do
      :timer.sleep(5000);
      :inet_res.nslookup(System.get_env("APP_NAME")<>".default.svc.cluster.local." |> IO.inspect |> to_charlist,:in,:a)
      |> IO.inspect
      |> extract_ip_list()
      |> IO.inspect
      |> Enum.each(fn {a,b,c,d} ->
        IO.inspect Node.connect( :"#{System.get_env("MY_POD_NAMESPACE")}@#{a}.#{b}.#{c}.#{d}" ) #<- connect
      end)
    rescue
      err ->err
    end

  end
end
