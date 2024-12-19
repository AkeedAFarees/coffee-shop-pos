// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
    // Select the flash message element
    const flashMessage = document.querySelector('.flash-messages');
  
    if (flashMessage) {
      setTimeout(() => {
        flashMessage.classList.add('fade-out');
    }, 2500);
    }
  });
  
