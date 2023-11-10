document.addEventListener("DOMContentLoaded", function () {
    const seeAll = document.getElementById('all')

    const display1 = document.querySelector('.display1')
    const display2 = document.querySelector('.display2')

    if (seeAll) {
        console.log('2');
        seeAll.addEventListener('click', () => {
            console.log('3');
            if (display1.classList.contains('posts-relaxed')) {
                display1.classList.add('posts-expanded')
                display1.classList.remove('posts-relaxed')

                display2.classList.add('posts-relaxed')
                display2.classList.remove('posts-expanded')
                seeAll.innerHTML = 'See more posts'
            } else {
                display1.classList.add('posts-relaxed')
                display1.classList.remove('posts-expanded')

                display2.classList.add('posts-expanded')
                display2.classList.add('posts-relaxed')
                seeAll.innerHTML = 'See less posts'
            }
        });
    }
});
