/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AnswerDAO;
import DAO.QuestionDAO;
import DAO.QuizDAO;
import Model.Account;
import Model.Answer;
import Model.Question;
import Model.Quiz;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author kimdi
 */
public class QuizSubmitServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Account currUser = (Account) session.getAttribute("currUser");

// Read the request body
            StringBuilder requestBody = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }
            reader.close();

// Parse the JSON data
            JsonObject jsonData = new Gson().fromJson(requestBody.toString(), JsonObject.class);
            String questionIdParam = jsonData.get("questionId").getAsString();
            String timeLeftParam = jsonData.get("timeLeft").getAsString();
            JsonArray selectedChoicesArray = jsonData.get("selectedChoices").getAsJsonArray();

            if (questionIdParam == null || timeLeftParam == null) {
                // Handle the case when the required parameters are missing
                String json = new Gson().toJson("error");
                response.getWriter().write(json);
            } else {
                int questionId = Integer.parseInt(questionIdParam);
                int timeLeft = Integer.parseInt(timeLeftParam);
                Set<Integer> selectedChoicesSet = new HashSet<>();
                for (JsonElement choice : selectedChoicesArray) {
                    selectedChoicesSet.add(choice.getAsInt());
                }
                QuestionDAO questionDAO = new QuestionDAO();
                QuizDAO quizDAO = new QuizDAO();
                AnswerDAO answerDAO = new AnswerDAO();
                Question question = questionDAO.getQuestionById(questionId);
                List<Quiz> quizzes = quizDAO.getQuizzesByQuestionId(questionId);
                float totalQuizCount = question.getQuizCount();
                float quizCount = 0;
                for (Quiz quizz : quizzes) {
                    int correctChoiceCount = 0;
                    List<Answer> answers = answerDAO.getCorrectAnswersByQuizId(quizz.getQuizId());
                    for (Answer answer : answers) {
                        if (selectedChoicesSet.contains(answer.getAnswerId())) {
                            correctChoiceCount++;
                        }
                    }
                    quizCount += (correctChoiceCount / answers.size());
                }
                float mark = (quizCount / totalQuizCount) * 10;

                //String json = new Gson().toJson(mark);
                //response.getWriter().write(json);
                // Store the mark in the session for later retrieval
                request.setAttribute("mark", mark);
                request.setAttribute("question", question);
                request.setAttribute("quizzes", quizzes);
                session.setAttribute("endTime", timeLeft);

                // Redirect to another page
                request.getRequestDispatcher("QuizHandleResult.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
