import 'package:flutter/material.dart';
import 'package:from_scratch/services/authenticate.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';



// void main() => runApp(Profile());

class Profile extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final appTitle = 'Change Password';

		return MaterialApp(
			title: appTitle,
			home: Scaffold(
				appBar: AppBar(
					title: Text(appTitle),
				),
				body: ProfileScreen(),
			),
		);
	}
}

// Create a Form widget.
class ProfileScreen extends StatefulWidget {
	@override
	ProfileState createState() {
		return ProfileState();
	}
}

// Create a corresponding State class.
// This class holds data related to the form.
class ProfileState extends State<ProfileScreen> {

	final _formKey = GlobalKey<FormState>();
	final Authservice _auth = Authservice();


	String _oldPassword ='';
	String _newPassword ='';
	String _confirmPassword ='';

	// old passoword widget
	Widget _buildOldPassword(){
		return TextFormField(
			decoration: InputDecoration(labelText: "Old Password"),
			validator: (value) {
				if (value.isEmpty) {
					return 'Fill this feild';
				}
				return null;
			},
			onSaved: (String value){
				_oldPassword = value;
			}
		);
	}

	Widget _buildNewPassword(){
		return TextFormField(
			decoration: InputDecoration(labelText: "New Password"),
			obscureText: true,
			validator: (value) {
				if (value.isEmpty) {
					return 'Fill this feild';
				}
				return null;
			},
			onSaved: (String value){
				_newPassword = value;
			}
		);
	}

	Widget _buildConfirmPassword(){
		return TextFormField(
			decoration: InputDecoration(labelText: "Confirm Password"),
			obscureText: true,
			validator: (value) {
				if (value.isEmpty) {
					return 'Fill this feild';
				}
				if(value != _newPassword ){
					return 'Passwords do not match';
				}
				return null;
			},
			onSaved: (String value){
				_confirmPassword = value;
			}
		);
	}

	// FirebaseUser user = await FirebaseAuth.instance.currentUser();
	//   AuthResult authResult = await user.reauthenticateWithCredential(
	//     EmailAuthProvider.getCredential(
	//       email: user.email,
	//       password: _oldPassword,
	//     ),
	//   );

	@override
	Widget build(BuildContext context) {
		// Build a Form widget using the _formKey created above.
		return Form(
			key: _formKey,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					_buildOldPassword(),
					_buildNewPassword(),
					_buildConfirmPassword(),

					Padding(
						padding: const EdgeInsets.symmetric(vertical: 16.0),

						child: RaisedButton(
							onPressed: () async{
								// Validate returns true if the form is valid, or false
								// otherwise.
								if (!_formKey.currentState.validate()) {
									return;
								}

								_formKey.currentState.save();
								final user = await _auth.getUser();
								final mailID = user.email;
								print(mailID);
								dynamic result = await _auth.signInWithEmail(mailID, _oldPassword);
								print("plz work");

								if(result != null){
									user.updatePassword(_newPassword).then((_){
										print("Succesfull changed password");
									}).catchError((error){
										print("Password can't be changed" + error.toString());
										//This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
									});

									// If the form is valid, display a Snackbar.
									Scaffold.of(context).showSnackBar(SnackBar(content: Text('Password Updated')));
								}

							},
							child: Text('Change'),
						),
					),
				],
			),
		);
	}
}
