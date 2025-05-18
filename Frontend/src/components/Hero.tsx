import React from "react";
import { Button } from "@/components/ui/button";

const Hero: React.FC = () => {
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
		<section className="relative pt-32 md:pt-40 md:px-4">
			<div className="container mx-auto text-center">
				<h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-6">
					Write Once, Execute Everywhere.
					{/* <span className="gradient-text block mt-2">Crypto</span> */}
				</h1>

				<p className="text-lg text-foreground/70 max-w-2xl mx-auto mb-8">
					AI co-pilot for the entire Web3 ecosystem, accessible through the simplest interface possible - the Notes app already on your Mac.
				</p>

				<div className="flex flex-col sm:flex-row gap-4 justify-center mb-16">
					<Button
						className="bg-gradient-primary hover:opacity-90 transition-opacity text-white px-8 py-6"
						onClick={() => {
							download();
						}}
					>
						Download
					</Button>
					<Button variant="outline" className="border-crypto-purple/30 text-foreground hover:bg-crypto-purple/5 hover:text-crypto-purple px-8 py-6 flex">
						<a className="w-full h-100%" href="https://github.com/Qinsir7/CryptoNote">Learn More</a>
					</Button>
				</div>

				<div className="relative w-full max-w-4xl mx-auto aspect-video rounded-xl glass-card p-1 overflow-hidden animate-float">
					<div className="w-full h-full bg-crypto-dark-bg rounded-lg flex items-center justify-center">
						<iframe
							width="100%"
							height="100%"
							src="https://www.youtube.com/embed/w5MCAacR_1U?si=9IjCaTL8qSMlzpeW"
							title="CryptoNote Demo"
							frameBorder="0"
							allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
							referrerPolicy="strict-origin-when-cross-origin"
							allowFullScreen
						></iframe>
					</div>
				</div>
			</div>
		</section>
	);
};

export default Hero;
