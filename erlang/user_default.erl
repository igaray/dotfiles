-module(user_default).

-compile(export_all).

mk() ->
  up_to_date = make:all([load]).

-spec test(atom()) -> _.
test(Mod) ->
  test(Mod, Mod:all()).

-spec test(atom(), [atom()]) -> _.
test(Mod, Tests) ->
  Config =
    case lists:member({init_per_suite, 1}, Mod:module_info(exports)) of
      true ->
        io:format("INITIALIZING...~n~n"),
        Mod:init_per_suite([]);
      false -> []
    end,
  io:format("TESTING...~n~n"),
  try
    [begin
      InitConfig =
        case lists:member({init_per_testcase, 2}, Mod:module_info(exports)) of
          true ->
            io:format("PREPARING ~p ~n~n", [Test]),
            Mod:init_per_testcase(Test, Config);
          false -> Config
        end,
      io:format("RUNNING ~p ~n~n", [Test]),
      try Mod:Test(InitConfig) of
        _ ->
          io:format("DONE ~p ~n~n", [Test]), {Test, ok}
      catch
        Kind:Error ->
          io:format("~p: ~p~n\t~p~n\t~p ~n~n", [Kind, Test, Error, erlang:get_stacktrace()]),
          {Test, {error, Error}}
      after
        case lists:member({end_per_testcase, 2}, Mod:module_info(exports)) of
          true ->
            io:format("CLOSING ~p ~n~n", [Test]),
            Mod:end_per_testcase(Test, InitConfig),
            io:format("CLOSED ~p ~n~n", [Test]);
          false -> ok
        end
      end
     end || Test <- Tests]
  after
    case lists:member({init_per_suite, 1}, Mod:module_info(exports)) of
      true ->
        io:format("CLOSING~n~n"),
        timer:sleep(1000),
        Mod:end_per_suite(Config);
      false -> ok
    end,
    io:format("DONE~n~n")
  end.

redbug(What) ->
  catch redbug:stop(),
  timer:sleep(100),
  redbug:start(What, [{time, 9999999}, {msgs, 9999999}]).

dbg() ->
  config:update_log_level(debug).

