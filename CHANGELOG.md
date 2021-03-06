# 0.3.1
- Allow the gem to function without `awesome_print`.

# 0.3.0
- Since https://bugs.ruby-lang.org/issues/12696 was resolved with a doc change:
  - Enabled checks whenever anonymous classes are defined with a block by 
    - Instrumenting `Class::new` with a `anonymous_class_defined` hook
  - Made sure `class_eval` could still be used if block was not used
- Added better backtrace to see where the failing class is (instead of library code)

# 0.2.0
- Update handling for anonymous classes:
  - Fix tracepoint never being disabled
  - Create an implementation that uses `class_eval`
- Make sure that any existing inherited hooks don't get overriden.

# 0.1.0
- Initial release
