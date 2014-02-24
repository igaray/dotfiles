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

-spec all_modules() -> module().
all_modules() ->
  [ list_to_atom(
      re:replace(
        filename:basename(F), "[.]beam$", "", [{return, list}]))
    ||  P <- code:get_path(),
        string:str(P, code:lib_dir()) == 0,
        F <- filelib:wildcard(filename:join(P, "*.beam"))].

-spec all_behaviours() -> module().
all_behaviours() ->
  [{B,F,A} || M <- all_modules(),
              B <- proplists:get_value(
                    behaviour, M:module_info(attributes),
                    proplists:get_value(behavior, M:module_info(attributes), [])),
              {F,A} <- B:behaviour_info(callbacks)].

-spec is_behaviour_callback(module(), function(), integer(), [tuple()]) -> boolean().
is_behaviour_callback(M,F,A,BFAs) ->
  case proplists:get_value(
          behaviour, M:module_info(attributes),
          proplists:get_value(behavior, M:module_info(attributes), [])) of
    [] -> false;
    [B] -> lists:member({B,F,A}, BFAs)
  end.

-spec not_used(atom()) -> _.
not_used(App) ->
  not_used(App, fun(_) -> true end).

-spec not_used(atom(), fun((mfa()) -> boolean())) -> [mfa()].
not_used(App, Filter) ->
  {ok, _} = xref:start(?MODULE),
  try
    LibDir =
      case code:lib_dir(App) of
        {error, _} -> ".";
        Dir -> Dir
      end,
    xref:set_default(?MODULE, [{recurse, true},{verbose, true}, {warnings, true}]),
    {ok, App} = xref:add_application(?MODULE, LibDir, [{name, App}]),
    {ok, All} = xref:analyze(?MODULE, exports_not_used),
    Behs = all_behaviours(),
    [MFA || MFA = {M,F,A} <- All,
            not is_behaviour_callback(M,F,A,Behs),
            Filter(MFA)]
  after
    xref:stop(?MODULE)
  end.

-spec choosy_not_used() -> [mfa()].
choosy_not_used() ->
  not_used(
    choosy,
    fun ({choosy_repo, _, _}) -> false;
        ({choosy, _, _})      -> false;
        ({choosy_sup, _, _})  -> false;
        ({_, start_link, _})  -> false;
        ({M, _, _}) ->
          case lists:reverse(atom_to_list(M)) of
            lists:reverse("_handler") ++ _ -> false;
            lists:reverse("_SUITE")   ++ _ -> false;
            _                              -> true
          end
    end).

-spec cmd(iodata()) -> _.
cmd(Cmd) ->
  io:format("~s~n", [os:cmd(Cmd)]).

