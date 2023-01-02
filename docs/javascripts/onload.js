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

function lightRope() {
  let ul = document.createElement('ul');

  ul.classList.add('lightrope');

  for (let i = 0; i < 50; i++) {
    ul.append(document.createElement('li'));
  }

  let main = document.querySelector('.md-main');

  if (main) {
    main.prepend(ul);
  }

  let t = document.querySelector('body > header > nav > div.md-header__title');

  if (t) {
    let btn = document.createElement('button');
    btn.classList.add('md-header__button', 'md-icon', 'snowflake');
    const update = () => {
      if (btn.hasAttribute('hidden')) {
        btn.removeAttribute('hidden');
        ul.classList.remove('off');
        window.localStorage.removeItem('--snowflake-hidden');
      } else {
        btn.setAttribute('hidden', '');
        ul.classList.add('off');
        window.localStorage.setItem('--snowflake-hidden', 'true');
      }
    };
    if (window.localStorage.getItem('--snowflake-hidden')) {
      update();
    }
    btn.addEventListener('click', update);
    t.after(btn);
  }
}

function externalMenuLinks() {
  document.querySelectorAll('body > div.md-container > nav .md-tabs__list > li > a').forEach(link => {
    if (link.getAttribute('href').startsWith('https://')) {
      link.classList.add('external-link');
      link.setAttribute('target', '_blank');
      link.textContent = link.textContent.trim();
    }
  });
}

window.addEventListener('load',  () => {
  externalMenuLinks();

  if (document.querySelector('.not-found')) {
    generateStars(document.body);
  } else {
    try {
      lightRope();
    } catch(e) {
      // for old browsers
    }
  }
});
