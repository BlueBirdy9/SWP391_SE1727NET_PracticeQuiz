<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- META ============================================= -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="" />
	<meta name="author" content="" />
	<meta name="robots" content="" />
	
	<!-- DESCRIPTION -->
	<meta name="description" content="EduChamp : Education HTML Template" />
	
	<!-- OG -->
	<meta property="og:title" content="EduChamp : Education HTML Template" />
	<meta property="og:description" content="EduChamp : Education HTML Template" />
	<meta property="og:image" content="" />
	<meta name="format-detection" content="telephone=no">
	
	<!-- FAVICONS ICON ============================================= -->
	<link rel="icon" href="../error-404.html" type="image/x-icon" />
	<link rel="shortcut icon" type="image/x-icon" href="admin/assets/images/favicon.png" />
	
	<!-- PAGE TITLE HERE ============================================= -->
	<title>EduChamp : Education HTML Template </title>
	
	<!-- MOBILE SPECIFIC ============================================= -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--[if lt IE 9]>
	<script src="assets/js/html5shiv.min.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
	
	<!-- All PLUGINS CSS ============================================= -->
	<link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
	<link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">
	
	<!-- TYPOGRAPHY ============================================= -->
	<link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">
	
	<!-- SHORTCODES ============================================= -->
	<link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">
	
	<!-- STYLESHEETS ============================================= -->
	<link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
	<link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
	<link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/add-quiz.css">
        <style>
            .answercheckbox {
                margin-left: 4em;
                margin-top: 0.5em;
                width: 2em;
                height: 2em;
            }
            .answerradio{
                margin-left: 4em;
                margin-top: 0.5em;
                width: 2em;
                height: 2em;
            }
            .answerinput {
                margin-left: 120px; 
                margin-right: 30px; 
                border: none;
                border-bottom: 1px solid grey;
                outline: none;
            }
            .form-control.answerinput {
                font-size: 14px;
              }
            .form-control.answerinput::placeholder {
                font-size: 14px;
              }
            
            .typeRadio {
                margin-left: 20px; 
                margin-right: 20px; 
            }
            .question-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 3px rgba(1, 1, 1, 1);
            margin-bottom: 20px;
            }
            .card.p-4.mb-3{
                background-color: #E0DADF
            }
            
        </style>
    </head>
    <body>
    <jsp:include page="Dashboard_header.jsp"></jsp:include>  
    <main class="ttr-wrapper">
        <form onsubmit="return validateForm()" action="createquiz" method="POST">
            <div class="container">
        <!-- Question and Answers -->
        <div class="mb-4">
                <h2>Create new Quiz</h2>
                <div class="card p-4">
                <div class="row mb-3" >
                    <div class="col-sm-1 ">
                         <label>Type:</label>
                     </div>
                     <div>
                         <input class="form-check-input" type="radio" name="quizType" value="0" checked onchange="updateCheckboxes()">
                     </div>
                     <div class="col-sm-3">
                         <label class="form-check-label">Multiple correct answers</label>
                     </div>
                     <div >
                         <input class="form-check-input" type="radio" name="quizType" value="1" onchange="updateCheckboxes()">
                     </div>
                     <div class="col-sm-3">
                         <label class="form-check-label">One correct answer</label>
                     </div>
                 </div>
                    <hr>
                    <label class="form-label">Question: </label>
                     <div class="question-card mb-3">
                         <input type="text" name="content" class="form-control answerinput" id="questionText" placeholder="Type your quiz content here" style="margin-left: 0px; border-bottom: none">
                     </div>
                </div>
            
                </br>
                <div class=" card p-4 mb-3">
                    <label class="form-label">Answers</label>
                    <div class="question-card form-check input-group mb-3">
                        <input class="form-check-input answercheckbox" type="checkbox" name="checkbox" value="incorrect" onchange="updateCheckbox(this)" >
                        <input class="form-check-input answerradio" type="radio" name="checkbox" value="incorrect" onchange="updateCheckbox(this)" >
                        
                        <input type="hidden" name="isCorrect" value =" incorrect">
                        <input type="text" name="answer" class="form-control col-sm-8 answerinput" placeholder="Type answer option here">
                        <button class="input-group-text remove-answer" onclick="removeRow(this)">
                            <i class="fa fa-trash"></i>
                        </button>
                    </div>
                    <div class=" question-card form-check input-group mb-3">
                        <input class="form-check-input answercheckbox" type="checkbox" name="checkbox" value="incorrect" onchange="updateCheckbox(this)" >
                        <input class="form-check-input answerradio" type="radio" name="checkbox" value="incorrect" onchange="updateCheckbox(this)" >
                        
                        <input type="hidden" name="isCorrect" value =" incorrect">
                        <input type="text" name="answer" class="form-control col-sm-8 answerinput" placeholder="Type answer option here">
                        <button class="input-group-text remove-answer" onclick="removeRow(this)">
                            <i class="fa fa-trash"></i>
                        </button>
                    </div>
                    <div class="question-card form-check input-group mb-3 ">
                        <input class="form-check-input answercheckbox " type="checkbox" name="checkbox" value="incorrect" onchange="updateCheckbox(this)">
                        <input class="form-check-input answerradio" type="radio" name="checkbox" value="incorrect" onchange="updateCheckbox(this)" >
                        
                        <input type="hidden" name="isCorrect" value =" incorrect">
                        <input type="text" name="answer" class="form-control col-sm-8 answerinput" placeholder="Type answer option here">
                        <button class="input-group-text remove-answer" onclick="removeRow(this)">
                            <i class="fa fa-trash"></i>
                        </button>
                    </div>
                    <div class="question-card form-check input-group mb-3">
                        <input class="form-check-input answercheckbox" type="checkbox" name="checkbox" value="incorrect" onchange="updateCheckbox(this)">
                        <input class="form-check-input answerradio" type="radio" name="checkbox" value="incorrect" onchange="updateCheckbox(this)" >
                        
                        <input type="hidden" name="isCorrect" value =" incorrect">
                        <input type="text" name="answer" class="form-control col-sm-8 answerinput" placeholder="Type answer option here">
                        <button class="input-group-text remove-answer" onclick="removeRow(this)">
                            <i class="fa fa-trash"></i>
                        </button>
                    </div>

                </div >
                <div class="card p-4 form-check input-group mb-3 " id="description-explaination" style="display: none; background-color: #E0DADF">
                    <div class="question-card">
                        <label class="form-label answerinput">Description or Explaination for correct answers</label>
                        <div>
                            <textarea name="description" class="form-control col-sm-8 answerinput"> </textarea>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-primary add-answer" onclick="addRow()">Add Answer</button>
                <button type="button" class="btn btn-primary add-answer" onclick="addDescription()">Add Description</button>  
            </div>
        </div>
          
        <!-- Add Question Button -->
        <button type="submit" class="btn btn-primary" id="addQuestion">Save Quiz</button>
        <button type="reset" class="btn btn-primary" id="addQuestion">Reset</button>
        </form>
    </main>
</body>
<script>
        function updateCheckboxes() {
            var quizType = document.querySelector('input[name="quizType"]:checked').value;
            var checkboxes = document.querySelectorAll('.answercheckbox');
            var radioInputs = document.querySelectorAll('.answerradio');
            var hiddenInput;
            
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].style.display = (quizType === '0') ? 'block' : 'none';
                checkboxes[i].checked = false;
                hiddenInput = checkboxes[i].parentElement.querySelector('input[type="hidden"]');
                hiddenInput.value = "incorrect";
            }
            for (var i = 0; i < radioInputs.length; i++) {
                radioInputs[i].style.display = (quizType === '1') ? 'block' : 'none';
                radioInputs[i].checked = false;
                hiddenInput = radioInputs[i].parentElement.querySelector('input[type="hidden"]');
                hiddenInput.value = "incorrect";
            }
        }
        updateCheckboxes();
 </script>
<script>
        document.addEventListener('DOMContentLoaded', function () {
            var radioButtons = document.getElementsByName('quizType');
            var answerCheckboxes = document.querySelectorAll('input[name="checkbox"]');
            function updateTextVisibility() {
                var selectedValue = document.querySelector('.answercheckbox').value;
                for (var i = 0; i < answerCheckboxes.length; i++) {
                    if (selectedValue === '0') {
                        answerCheckboxes.style.display = 'block';
                    } else if (selectedValue === '1') {
                        answerCheckboxes.style.display = 'none';
                    }
                }
            }

            // Initial setup
            updateTextVisibility();

            // Add event listener to radio buttons
            for (var i = 0; i < radioButtons.length; i++) {
                radioButtons[i].addEventListener('change', updateTextVisibility);
            }
        });
    </script>
<script>
        function validateForm() {
            var questionTextValue = document.getElementById('questionText').value.trim();
            if (questionTextValue === '') {
                alert('Please fill in the question text');
                return false;
            }

            var answerInputs = document.querySelectorAll('.answerinput');

            for (var i = 0; i < answerInputs.length; i++) {
                var answerInputValue = answerInputs[i].value.trim();

                if (answerInputValue === '') {
                    alert('Please fill in all answer options');
                    return false;
                }
            }
            var checkboxInputs = document.querySelectorAll('.answercheckbox');
            var atLeastOneSelected = false;
            for (var i = 0; i < checkboxInputs.length; i++) {
                if (checkboxInputs[i].checked) {
                    atLeastOneSelected = true;
                    break;
                }
            }

            if (!atLeastOneSelected) {
                alert('Please select at least one correct answer');
                return false;
            }

            return true;
        }
    </script>
<script>

function updateCheckbox(checkbox) {
    // Check if the checkbox is checked
    var isChecked = checkbox.checked;
    
    // Find the hidden input element within the same parent div
    var hiddenInput = checkbox.parentElement.querySelector('input[type="hidden"]');
    
    if (isChecked) {
        // If the checkbox is checked, set the hidden input value to "correct"
        hiddenInput.value = "correct";
    } else {
        // If the checkbox is not checked, set the hidden input value to "incorrect"
        hiddenInput.value = "incorrect";
    }
    
    // Optional: Log the hidden input value for testing
    console.log(hiddenInput.value);
}
</script>

    
<script>
    
    function removeRow(button){
        var rows = document.querySelectorAll('.form-check.input-group.mb-3');
        if(rows.length >2){
           var row = button.parentElement; // get the element contain button
            row.remove(); 
        }
    }
</script>
<script>
    function addDescription(){
        var div = document.getElementById("description-explaination");
        if (div.style.display === "none" || div.style.display === "") {
            div.style.display = "block"; // Hiện thẻ div
        } else {
            div.style.display = "none"; // Ẩn thẻ div
        }
    }
    
</script> 

<script>
    function addRow(){
        var rows = document.querySelectorAll('.form-check.input-group.mb-3');
        if(rows.length < 8){
            var originalRow = document.querySelector('.form-check.input-group.mb-3');
            var newRow = originalRow.cloneNode(true);
            console.log("Số dòng hiện tại: " + rows.length);
            
            var newCheckbox = newRow.querySelector('input[type="checkbox"]');
            
            newCheckbox.onchange = function() {
                updateCheckbox(newCheckbox);
            };
            
            newRow.querySelector('input[type="text"]').value = '';
            originalRow.parentElement.appendChild(newRow);
        }
        else if (rows.length >= 8){
            alert("Số dòng đã đạt tối đa.");
        }
    }
</script>
</html>
