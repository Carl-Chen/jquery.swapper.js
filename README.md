jquery.swapper.js
===
The plugin swap element positions by CSS animation.


Requirements
---
[jQuery](http://jquery.com/) or [Zepto](http://zeptojs.com/)


Usage
---
```javascript
$('#foo').swapper('#bar');

$('#hoge').swapper('#piyo', {
  duration: 300,
  timing:   'ease-in',
  callback: function() {
    alert('fuga');
  }
});
```


Build
---
```shell
npm install
grunt
```
=> jquery.swapper.js
