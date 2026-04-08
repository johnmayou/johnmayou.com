document.addEventListener('click', e => {
  const link = e.target.closest('a.footnote-backref');
  if (!link) return;
  const target = document.getElementById(link.getAttribute('href').slice(1));
  if (!target) return;
  e.preventDefault();
  window.scrollTo({ top: target.getBoundingClientRect().top + window.scrollY, behavior: 'smooth' });
});
