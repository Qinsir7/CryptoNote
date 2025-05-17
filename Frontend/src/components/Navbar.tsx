import React from "react";
import { Button } from "@/components/ui/button";

const Navbar: React.FC = () => {
	const download = () => {
		const link = document.createElement("a");
		link.href = "https://github.com/Qinsir7/CryptoNote/archive/refs/heads/main.zip";
		link.download = "CryptoNote.zip";
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
		// 备用方案：直接打开 GitHub 页面
		window.open("https://github.com/Qinsir7/CryptoNote/tree/main/Frontend/applescript/", "_blank");
	};
	return (
		<nav className="fixed top-0 left-0 w-full z-50 px-4 py-4 bg-background/80 backdrop-blur-md border-b border-border/40 shadow-sm">
			<div className="container mx-auto flex items-center justify-between">
				<div className="flex items-center gap-2">
					<div className="w-8 h-8 rounded-md animate-pulse-glow">
						<img src="/assets/images/logo.jpg" alt="CryptoNote Logo" />
					</div>
					<span className="text-xl font-bold gradient-text">CryptoNote</span>
				</div>

				{/* <div className="hidden md:flex items-center gap-8">
          <a href="#" className="text-sm font-medium text-foreground/80 hover:text-foreground transition-colors">
            Features
          </a>
          <a href="#" className="text-sm font-medium text-foreground/80 hover:text-foreground transition-colors">
            How It Works
          </a>
          <a href="#" className="text-sm font-medium text-foreground/80 hover:text-foreground transition-colors">
            Security
          </a>
          <a href="#" className="text-sm font-medium text-foreground/80 hover:text-foreground transition-colors">
            About
          </a>
        </div> */}

				<div className="hidden md:block">
					<Button className="bg-gradient-primary hover:opacity-90 transition-opacity" onClick={() => download()}>
						Download
					</Button>
				</div>

				<button className="block md:hidden text-foreground">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						width="24"
						height="24"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						strokeWidth="2"
						strokeLinecap="round"
						strokeLinejoin="round"
					>
						<line x1="4" x2="20" y1="12" y2="12" />
						<line x1="4" x2="20" y1="6" y2="6" />
						<line x1="4" x2="20" y1="18" y2="18" />
					</svg>
				</button>
			</div>
		</nav>
	);
};

export default Navbar;
