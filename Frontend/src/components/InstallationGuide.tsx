import React, { useState } from "react";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";

const InstallationGuide: React.FC = () => {
	const { toast } = useToast();
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
		<section id="installation" className="py-20 px-4 bg-gradient-to-b from-background to-crypto-purple/5">
			<div className="container mx-auto">
				<div className="text-center mb-16">
					<h2 className="text-3xl md:text-4xl font-bold mb-4">Easy Installation</h2>
					<p className="text-foreground/70 max-w-2xl mx-auto">Get started with CryptoNote in just two simple steps</p>
				</div>

				<div className="grid md:grid-cols-2 gap-8 max-w-5xl mx-auto">
					{/* Step 1 */}
					<div className="glass-card p-6 md:p-8 rounded-xl flex flex-col gap-3">
						<div className="w-12 h-12 rounded-full bg-gradient-primary flex items-center justify-center text-white font-bold mb-4">1</div>
						<h3 className="text-xl font-bold mb-3">Download & Install</h3>
						{/* <p className="text-foreground/70 mb-6">
							Download our secure script and apply it to your MacBook. The script will set up the needed environment for AI agent for CryptoNote.
						</p> */}
						<p>1. Download the CryptoNote package</p>
						<p>2. Unzip the package to a location of your choice</p>
						<div>
							<p>3. Open Terminal and navigate to the extracted folder:</p>
							<div className="bg-crypto-dark-bg rounded-lg p-4">
								<pre className="text-white text-sm overflow-x-auto">
									{/* TODO: update the text */}
									<code>cd ~/Downloads/setup.sh</code>
								</pre>
							</div>
						</div>
						<div>
							<p>4. Run the setup script:</p>
							<div className="bg-crypto-dark-bg rounded-lg p-4 mb-3">
								<pre className="text-white text-sm overflow-x-auto">
									<code>
										sudo chmod +x setup.sh
										<br />
										./setup.sh
									</code>
								</pre>
							</div>
						</div>
						<p>5. Follow on-screen prompts to complete the installation</p>
						<div className="flex justify-center mt-auto">
							<Button
								className="bg-crypto-blue hover:bg-crypto-blue/90"
								onClick={() => {
									download();
								}}
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									width="18"
									height="18"
									viewBox="0 0 24 24"
									fill="none"
									stroke="currentColor"
									strokeWidth="2"
									strokeLinecap="round"
									strokeLinejoin="round"
									className="mr-2"
								>
									<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
									<polyline points="7 10 12 15 17 10" />
									<line x1="12" y1="15" x2="12" y2="3" />
								</svg>
								Download
							</Button>
						</div>
					</div>

					{/* Step 2 */}
					<div className="glass-card p-6 md:p-8 rounded-xl flex flex-col gap-3">
						<div className="w-12 h-12 rounded-full bg-gradient-primary flex items-center justify-center text-white font-bold mb-4">2</div>
						<h3 className="text-2xl font-bold">Using CryptoNote</h3>
						<p>1. Open the Notes app and navigate to the ‘CryptoNote’ folder.</p>
						<p>2. Select any of the specialized notes</p>
						<p>3. Type in your request, followed by the trigger word ‘@crypto’</p>
						<p>4. Wait a moment for CryptoNote to process your request</p>
					</div>
				</div>
			</div>
		</section>
	);
};

export default InstallationGuide;
