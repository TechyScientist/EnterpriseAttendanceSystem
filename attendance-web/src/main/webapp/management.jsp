<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>
<style>
    div#horizontal-3 {
        display: grid;
        max-width: fit-content;
        grid-template-columns: auto auto auto;
        column-gap: 20px;
    }

    .image-button {
        display: grid;
        grid-template-columns: auto auto;
        column-gap: 5px;
    }

    .image-button img {
        width: 25px;
        aspect-ratio: 1/1;
    }
</style>

<h2>System Management</h2>
<div id="horizontal-3">
    <div>
        <h3>User Management</h3>
        <a href="add-user.jsp" class="image-button"><span>Add User</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
        <a href="" class="image-button"><span>Reassign User Prox Data</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
        <a href="" class="image-button"><span>Edit User</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
        <a href="remove-user.jsp" class="image-button"><span>Remove User</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
    </div>
    <div>
        <h3>Course Management</h3>
        <a href="" class="image-button"><span>Add Course Section</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
        <a href="" class="image-button"><span>Edit Course Section</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
        <a href="" class="image-button"><span>Remove Course Section</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
    </div>
    <div>
        <h3>Registration Center</h3>
        <a href="" class="image-button"><span>Enrol User in Course</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
        <a href="" class="image-button"><span>Withdraw User from Course</span><img src="assets/img/proceed.png" alt="Proceed"/></a>
    </div>
</div>
<%@ include file="assets/include/footer.jsp" %>