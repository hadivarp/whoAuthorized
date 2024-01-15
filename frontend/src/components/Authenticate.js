import React, { useState } from 'react';
import './style.css';

const Authenticate = () => {
    const [isSignup, setIsSignup] = useState(false);
    const [credentials, setCredentials] = useState({
        name: '',
        last_name: '',
        email: '',
        password: '',
    });

    const handleToggle = () => {
        setIsSignup(!isSignup);
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setCredentials((prevCredentials) => ({
            ...prevCredentials,
            [name]: value,
        }));
    };

    const handleSubmit = () => {
        if (isSignup) {
            // API call for sign-up
            fetch('http://localhost:4000/sign_up', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(credentials),
            })
                .then((response) => response.json())
                .then((data) => {
                    // Handle sign-up response as needed
                    console.log(data);
                })
                .catch((error) => {
                    console.error('Error during sign-up:', error);
                });
        } else {
            // API call for sign-in
            fetch('http://localhost:4000/sign_in', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(credentials),
            })
                .then((response) => response.json())
                .then((data) => {
                    // Handle sign-in response as needed
                    console.log(data);
                })
                .catch((error) => {
                    console.error('Error during sign-in:', error);
                });
        }
    };

    return (
        <>
            <br />
            <br />
            <div className={`cont ${isSignup ? 's--signup' : ''}`}>
                <div className="form sign-in">
                    <h2>Welcome</h2>
                    <label>
                        <span>Email</span>
                        <input type="email" name="email" onChange={handleChange} />
                    </label>
                    <label>
                        <span>Password</span>
                        <input type="password" name="password" onChange={handleChange} />
                    </label>
                    <p className="forgot-pass">Forgot password?</p>
                    <button type="button" className="submit" onClick={handleSubmit}>
                        Sign {isSignup ? 'Up' : 'In'}
                    </button>
                </div>
                <div className="sub-cont">
                    <div className="img">
                        <div className="img__text m--up">
                            <h3>Don't have an account? Please Sign up!</h3>
                        </div>
                        <div className="img__text m--in">
                            <h3>If you already have an account, just sign in.</h3>
                        </div>
                        <div className="img__btn" onClick={handleToggle}>
                            <span className="m--up">Sign Up</span>
                            <span className="m--in">Sign In</span>
                        </div>
                    </div>
                    <div className="form sign-up">
                        <h2>Create your Account</h2>
                        <label>
                            <span>Name</span>
                            <input type="text" name="name" onChange={handleChange} />
                        </label>
                        <label>
                            <span>Last Name</span>
                            <input type="text" name="last_name" onChange={handleChange} />
                        </label>
                        <label>
                            <span>Email</span>
                            <input type="email" name="email" onChange={handleChange} />
                        </label>
                        <label>
                            <span>Password</span>
                            <input type="password" name="password" onChange={handleChange} />
                        </label>
                        <button type="button" className="submit" onClick={handleSubmit}>
                            Sign Up
                        </button>
                    </div>
                </div>
            </div>
        </>
    );
};

export default Authenticate;
