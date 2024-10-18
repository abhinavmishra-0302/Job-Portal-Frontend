import React from 'react';
import './SplashScreen.css';

const SplashScreen: React.FC = () => {
    return (
        <div className="splash-screen">
            <center><h1>Job Portal</h1></center>
    <p>Loading...</p>
    {/* You can add a spinner or other loading indicators here */}
    </div>
);
};

export default SplashScreen;
