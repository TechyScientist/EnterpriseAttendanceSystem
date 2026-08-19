<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/register.jsp");
</script>

<h2>Registration Center: Register Student</h2>
<form action="" method="post" style="display: grid; grid-template-rows: auto auto; grid-template-columns: auto auto; grid-template-areas: 'course student' 'submit submit'; gap: 10px;">
    <div style="grid-area: course;">
        <h3>Course Section Information</h3>
        <div class="form-field">
            <label for="term">Term</label>
            <input type="text" id="term" name="term" required/>
        </div>
        <div class="form-field">
            <label for="subject">Subject Area</label>
            <input type="text" id="subject" name="subject" required/>
        </div>
        <div class="form-field">
            <label for="number">Course Number</label>
            <input type="text" id="number" name="number" required/>
        </div>
        <div class="form-field">
            <label for="section">Section Code</label>
            <input type="text" id="section" name="section" required/>
        </div>
    </div>
    <div style="grid-area: student;">
        <h3>Student Information</h3>
        <div class="form-field">
            <label for="prox">Prox Information</label>
            <input type="text" id="prox" name="prox" required/>
        </div>
    </div>
    <button type="submit" id="register-submit" name="register-submit" style="grid-area: submit; justify-self: center;">Submit Registration Request <img src="assets/img/proceed.png" alt="Proceed"/></button>
</form>

<%@ include file="assets/include/footer.jsp" %>