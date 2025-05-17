
import React from 'react';

const AnimatedBackground: React.FC = () => {
  return (
    <div className="absolute inset-0 -z-10 overflow-hidden">
      <div className="absolute top-0 left-0 w-full h-full bg-hero-pattern"></div>
      <div className="absolute top-1/3 -left-64 w-96 h-96 rounded-full bg-crypto-purple/20 blur-3xl"></div>
      <div className="absolute top-2/3 -right-64 w-96 h-96 rounded-full bg-crypto-blue/20 blur-3xl"></div>
    </div>
  );
};

export default AnimatedBackground;
