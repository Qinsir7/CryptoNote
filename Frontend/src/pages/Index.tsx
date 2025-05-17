
import React from 'react';
import AnimatedBackground from '@/components/AnimatedBackground';
import Navbar from '@/components/Navbar';
import Hero from '@/components/Hero';
import InstallationGuide from '@/components/InstallationGuide';
import Features from '@/components/Features';
import Footer from '@/components/Footer';

const Index: React.FC = () => {
  return (
    <div className="relative min-h-screen overflow-hidden">
      <AnimatedBackground />
      <Navbar />
      <main>
        <Hero />
        <InstallationGuide />
        <Features />
      </main>
      <Footer />
    </div>
  );
};

export default Index;
