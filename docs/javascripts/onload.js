function randomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}

function generateStars($stars) {
  if (!window.requestAnimationFrame) {
    return;
  }

  let stars = [];

  let {width, height} = $stars.getBoundingClientRect();

  for (let i = 0; i < 1000; i++) {
    const el = document.createElement('div');
    el.classList.add('star');
    el.top = randomInt(0, height);
    el.left = randomInt(0, width);
    el.distance = randomInt(100, 1000);

    let klass = (() => {
      if (el.distance > 300) {
        return 'far';
      }
      if (el.distance > 150) {
        return 'middle';
      }
    })();

    if (klass) {
       el.classList.add(klass)
    }
    el.style.setProperty('top', el.top + 'px');
    el.style.setProperty('left', el.left + 'px');
    $stars.append(el);
    stars.push(el);
  }

  function animate() {
    stars.forEach(el => {
      el.top = el.top - 100/el.distance;
      if (el.top < 0) {
        el.top = height + el.top;
      }
      el.style.setProperty('top', el.top.toFixed(1) + 'px');
    });
    requestAnimationFrame(() => {
      requestAnimationFrame(animate);
    });
  }

  animate();
}

window.addEventListener('load',  () => {
  if (document.querySelector('.not-found')) {
    generateStars(document.body);
  }
});
