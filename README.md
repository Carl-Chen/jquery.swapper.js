jquery.swapper.js
=========
2つの要素をCSSアニメーションでぬるっと入れ替えるjQueryプラグイン

Usage
-----
```javascript
$('#foo').swapper('#bar');

$('#hoge').swapper('#piyo', {
  duration: 300,
  timing: 'ease-in',
  callback: function() { 
    alert('fuga');
  }
});
