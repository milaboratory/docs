window.addEventListener('load',  () => {
  const images = Array.from(document.querySelectorAll("article img")).filter(img => {
    return img.src.endsWith('.svg');
  });

  // Promise.all(images.map(img => SVGInject(img, {
  //   makeIdsUnique: false
  // }))).catch(console.error);
});
