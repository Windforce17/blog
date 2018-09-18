## basic

init fps count
```js
var stats = new Stats();
stats.domElement.style.position = "absolute";
stats.domElement.style.left = "0px";
stats.domElement.style.top = "0px";
document.getElementById("Stats.output").appendChild(stats.domElement);
```

change stats format
```css
#stats #fps {
    background: transparent !important
}
            
#stats #fps #fpsText {
    color: #000000 !important
}
            
#stats #fps #fpsGraph {
    /*display: none;*/
}
```

init basic elements;

```js
var scene = new THREE.Scene();

var camera = new THREE.PerspectiveCamera(45,window.innerWidth / window.innerHeight, 0.1, 1000);
camera.position.x = -30;
camera.position.y = 40;
camera.position.z = 50;
camera.lookAt(new THREE.Vector3(0, 0, 0));

var renderer = new THREE.WebGLRenderer();
renderer.setClearColor(0xB9D3EE);
renderer.setSize(window.innerWidth,window.innerHeight);

container.appendChild(renderer.domElement);
scene.add(camera);
```

render
```js
function render(){
stats.update()//update fps count
requestAnimationFrame(render)
renderer.render(scene,camera);
}
```

