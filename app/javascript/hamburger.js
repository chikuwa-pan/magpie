const MenuContainer = document.querySelector('.hamburger');
const MenuOpen = document.querySelector('.menu_open');
const MenuClose = document.querySelector('.menu_close');

const SPMenu = document.querySelector('.sp_nav');			
  MenuContainer.addEventListener('click', () => {
    MenuOpen.classList.toggle('active');
    MenuClose.classList.toggle('active');
    SPMenu.classList.toggle('active');
  });