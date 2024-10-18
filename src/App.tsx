import React, { useState, useEffect } from 'react';
import SplashScreen from './components/SplashScreen';
import MainApp from './components/MainApp'; // Your main application component

const App: React.FC = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simulate a loading delay
    const timer = setTimeout(() => {
      setLoading(false);
    }, 3000);

    return () => clearTimeout(timer);
  }, []);

  return (
      <>
        {loading ? <SplashScreen /> : <MainApp />}
      </>
  );
};

export default App;
