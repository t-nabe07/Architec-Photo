$(document).on('turbolinks:load', function () {

  var swiper = new Swiper(".mySwiper", {
        effect: "cube",
        grabCursor: true,
        cubeEffect: {
          shadow: true,

          shadowOffset: 20,
          shadowScale: 0.44,
        },
        pagination: {
          el: ".swiper-pagination",
        },
      });

});