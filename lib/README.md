# LibSys - A Library management app
<title>CSC 517 - Project 1</title>

The application has
<ul>
<li>Pre configured admin with email: superUser@libsys.com password: Password12</li>
<li>Pre configured library members and a set of books</li>
<li>Some books have been issued to some library members</li>
</ul>
<h3>Basic Flow</h3>
<ul>
<li><p><b>Login:</b> Sign in using your email and password and choose the role you want to be logged in with. A new user can sign up as a member. New admin has to be created by an existing admin</p></li>
<li><b>Landing page:</b> It lists the functionalities available to the logged in user according to his role</li>
<li><b>Manage Member:</b>
<p>Test that an admin is able to view and delete a member. Admin can view profile details of a member and promote him to admin. Admin can also view the checkout history of any member, or return a book on his behalf</p></li>
<li><b>Manage Admin:</b>
<p>Test that an admin is able to view and delete other admins. But he can not delete SuperUser or himself</p></li>
<b>Note: </b>If a user has dual roles (both member and admin) deletion will just remove one role. If he has a single role then the user will be deleted. Also, if a member has a current reservation then admin will not be able to delete him unless the book is returned.
<li><b>Manage Books:</b>
<p>Test that an admin is able to view the whole book catalogue, edit books, view checkout history of books, add and delete a book. He can also checkout a book on behalf of an existing member by providing his email id. A book can not be checked out if a user is only Admin. An admin can also suggest a book.</p></li>
<li><b>View Book Suggestions: </b>An admin can view all the book suggestions</li>
<li><b>Profile Details:</b> Allows both member and admin to update their profile details.</li>
<li><b>Books Catalogue:</b> This option is given to a member to checkout an available book</li>
</ul>
