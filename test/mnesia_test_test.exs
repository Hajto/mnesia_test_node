defmodule MnesiaTestTest do
  use ExUnit.Case
  doctest MnesiaTest

  @sample_DNS {:ok,
               {:dns_rec,
                {:dns_header, 1, true, :query, false, false, true, true, false, 0},
                [{:dns_query, 'erlangpl-demo-mnesia.default.svc.cluster.local', :a, :in}],
                [{:dns_rr, 'erlangpl-demo-mnesia.default.svc.cluster.local', :a, :in, 0, 24, {172, 17, 0, 3}, :undefined, [], false}], [], []}
  }

  test "the truth" do
    MnesiaTest.extract_ip_list(@sample_DNS) == [{172, 17, 0, 3}]
  end
end
