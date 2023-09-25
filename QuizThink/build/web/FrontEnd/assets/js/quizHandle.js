/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//quiz handle
//quiz handle
var quizCounter = 0;
var selectedChoices = [];

function toggleEffect(checkbox, limitCheck) {
    var selectedCheckboxes = document.querySelectorAll(
            'input[name="' + checkbox.name + '"]:checked'
            );

    // Limit the user to selecting only a specific number of options
    if (limitCheck != 0) {
        if (selectedCheckboxes.length > limitCheck) {
            checkbox.checked = false;
            return;
        }
    }

    var selectedLabel = document.querySelector('label[for="' + checkbox.id + '"]');
    var navButton = document.getElementById('quiz-nav-btn-' + checkbox.name);

    if (checkbox.checked) {
        selectedLabel.classList.add("selected");
        navButton.classList.add("selected");
        // Increment the quiz counter if at least one choice is selected
        if (selectedCheckboxes.length === 1) {
            quizCounter++;
        }
        // Add the selected choice to the array
        selectedChoices.push(checkbox.value);
    } else {
        selectedLabel.classList.remove("selected");
        navButton.classList.remove("selected");
        // Decrement the quiz counter if the last choice is deselected
        if (selectedCheckboxes.length === 0) {
            quizCounter--;
        }
        // Remove the deselected choice from the array
        var index = selectedChoices.indexOf(checkbox.value);
        if (index !== -1) {
            selectedChoices.splice(index, 1);
        }
    }

    // Update the counter display
    var counterElement = document.getElementById("quiz-counter");
    counterElement.textContent = quizCounter;
}
// Set the date we're counting down to
var countDownDate = new Date("Jan 5, 2024 15:37:25").getTime();

// Update the count down every 1 second
var x = setInterval(function () {

    // Get today's date and time
    var now = new Date().getTime();

    // Find the distance between now and the count down date
    var distance = countDownDate - now;

    // Time calculations for days, hours, minutes and seconds
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

    // Display the result in the element with id="demo"
    document.getElementById("question-timer").innerHTML = days + "d " + hours + "h "
            + minutes + "m " + seconds + "s ";

    // If the count down is finished, write some text
    if (distance < 0) {
        clearInterval(x);
        document.getElementById("question-timer").innerHTML = "EXPIRED";
    }
}, 1000);


function scrollToQuiz(quizNumber) {
    var quizElement = document.getElementById('quiz' + quizNumber);
    if (quizElement) {
        quizElement.scrollIntoView({behavior: 'smooth'});
    }
}

