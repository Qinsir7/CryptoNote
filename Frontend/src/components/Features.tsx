import React from "react";

const Features: React.FC = () => {
	const [count, setCount] = React.useState(1);
	const features = [
		{
			id: 4,
			title: "Memory",
			description: "Use anything your record to generate a picture, and preserve the important moment as NFT on chain",
			image: "/assets/images/memory.png",
			alt: "Memory",
		},
		{
			id: 3,
			title: "Analysis",
			description: "Fetch on-chain data analysis",
			image: "/assets/images/analysis.png",
			alt: "Analysis",
		},
		{
			id: 2,
			title: "News",
			description: "Update the web3 news",
			image: "/assets/images/news.png",
			alt: "News",
		},

		{
			id: 1,
			title: "Trade",
			description: "Execute cryptocurrency trades as you wish",
			image: "/assets/images/trade.png",
			alt: "Trade",
		},
	];
	React.useEffect(() => {
		const interval = setInterval(() => {
			setCount((prev) => {
				const next = prev >= features.length ? 1 : prev + 1;
				return next;
			});
		}, 2500); // 增加间隔时间
		return () => clearInterval(interval);
	}, [features.length]);

	return (
		<section className="py-20 px-4">
			<div className="container mx-auto">
				<div className="text-center mb-8">
					<h2 className="text-3xl md:text-4xl font-bold mb-4">Usage Examples</h2>
				</div>
				<p className="mb-16 text-lg text-foreground/50">Once installed, CryptoNote creates a folder called ‘CryptoNote’ in your Notes app with four specialized notes:</p>
				<div className="container mx-auto">
					<div className="relative h-[500px] overflow-hidden">
						{features.map((feature) => (
							<div
								key={feature.id}
								className={`absolute inset-0 transition-all duration-1000 ease-in-out transform-gpu
                ${feature.id === count ? "opacity-100 translate-y-0 z-10" : "opacity-0 translate-y-10 z-0"}`}
								style={{
									transitionProperty: "opacity, transform",
									pointerEvents: feature.id === count ? "auto" : "none",
								}}
							>
								<div className="flex flex-col gap-4 h-full">
									<div key={feature.id} className="flex flex-row gap-5 justify-between features h-full">
										<div className="text flex flex-col">
											<h4 className="flex text-2xl font-medium">{feature.title}</h4>
											<p className="text-foreground/70 mt-4 text-lg">{feature.description}</p>
										</div>
										<div className="w-[65%] aspect-video">
											{" "}
											{/* 新增固定尺寸容器 */}
											<img className="rounded-2xl w-full h-full object-cover" src={feature.image} alt={feature.alt} />
										</div>
									</div>
								</div>
							</div>
						))}
					</div>
				</div>
			</div>
		</section>
	);
};

export default Features;
