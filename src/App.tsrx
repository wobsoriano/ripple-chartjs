import { Line, Bar, Radar, Pie } from './lib';
import { track } from 'ripple';
import { Chart as ChartJS, registerables } from 'chart.js';

ChartJS.register(...registerables);
export component App() {
	let &[chartType] = track<'line' | 'bar' | 'radar' | 'pie'>('line');
	let &[smooth] = track(true);
	let &[stacked] = track(false);
	let &[showPoints] = track(true);
	let &[accent] = track<'reef' | 'sunset' | 'forest'>('reef');
	let &[seed] = track(1);

	const monthPool = [
		'Jan',
		'Feb',
		'Mar',
		'Apr',
		'May',
		'Jun',
		'Jul',
		'Aug',
		'Sep',
		'Oct',
		'Nov',
		'Dec',
	];

	const createSeries = (offset: number, points: number) => Array.from({ length: points }, (
		_,
		i,
	) => {
		const wave = Math.sin((i + seed + offset) * 0.72) * 16;
		const trend = 42 + i * (offset + 1) * 3;
		return Math.max(6, Math.round(trend + wave));
	});

	const createData = (points: number) => ({
		labels: monthPool.slice(0, points),
		datasets: [
			{
				id: 1,
				label: 'Revenue',
				data: createSeries(0, points),
				borderWidth: 3,
				borderColor: '#16a34a',
				backgroundColor: 'rgba(22, 163, 74, 0.24)',
				fill: chartType === 'line',
				tension: smooth ? 0.34 : 0,
				pointRadius: showPoints ? 4 : 0,
			},
			{
				id: 2,
				label: 'Cost',
				data: createSeries(2, points),
				borderWidth: 3,
				borderColor: '#0ea5e9',
				backgroundColor: 'rgba(14, 165, 233, 0.22)',
				fill: chartType === 'line',
				tension: smooth ? 0.34 : 0,
				pointRadius: showPoints ? 4 : 0,
			},
		],
	});

	let &[data] = track(createData(6));

	const axisColor = '#475569';
	const accentColor =
		accent === 'sunset'
			? '#f97316'
			: accent === 'forest'
				? '#22c55e'
				: '#06b6d4';

	const options = {
		responsive: true,
		maintainAspectRatio: false,
		plugins: {
			legend: {
				position: 'bottom',
				labels: {
					color: '#0f172a',
					font: {
						family: 'IBM Plex Sans',
						size: 12,
					},
				},
			},
			title: {
				display: true,
				text: 'Interactive Ripple + Chart.js playground',
				color: '#0f172a',
				font: {
					family: 'Fraunces',
					size: 16,
				},
			},
		},
		scales: {
			x: {
				stacked,
				grid: {
					color: 'rgba(148, 163, 184, 0.25)',
				},
				ticks: {
					color: axisColor,
				},
			},
			y: {
				stacked,
				grid: {
					color: 'rgba(148, 163, 184, 0.25)',
				},
				ticks: {
					color: axisColor,
				},
			},
		},
	};

	const refreshData = () => {
		data = createData(data.labels.length);
		seed++;
	};

	const addPoint = () => {
		if (data.labels.length >= 12) {
			return;
		}

		data = createData(data.labels.length + 1);
	};

	const removePoint = () => {
		if (data.labels.length <= 3) {
			return;
		}

		data = createData(data.labels.length - 1);
	};

	<div class={['shell', `accent-${accent}`]}>
		<section class="panel">
			<h1>{'ripple-chartjs playground'}</h1>
			<p class="caption">
				{'Switch chart types, tweak settings, and regenerate datasets to validate updates.'}
			</p>

			<div class="toolbar">
				<button
					class={chartType === 'line' && 'active'}
					onClick={() => (chartType = 'line')}
				>
					{'Line'}
				</button>
				<button class={chartType === 'bar' && 'active'} onClick={() => (chartType = 'bar')}>
					{'Bar'}
				</button>
				<button
					class={chartType === 'radar' && 'active'}
					onClick={() => (chartType = 'radar')}
				>
					{'Radar'}
				</button>
				<button class={chartType === 'pie' && 'active'} onClick={() => (chartType = 'pie')}>
					{'Pie'}
				</button>
			</div>

			<div class="controls">
				<label>
					<input
						type="checkbox"
						checked={smooth}
						onInput={(e) => (smooth = e.target.checked)}
					/>
					<span>{'Smooth curves'}</span>
				</label>
				<label>
					<input
						type="checkbox"
						checked={stacked}
						onInput={(e) => (stacked = e.target.checked)}
					/>
					<span>{'Stacked axes'}</span>
				</label>
				<label>
					<input
						type="checkbox"
						checked={showPoints}
						onInput={(e) => (showPoints = e.target.checked)}
					/>
					<span>{'Visible points'}</span>
				</label>
			</div>

			<div class="row">
				<button onClick={refreshData}>{'Randomize values'}</button>
				<button onClick={addPoint}>{'Add month'}</button>
				<button onClick={removePoint}>{'Remove month'}</button>
			</div>

			<div class="row swatches">
				<button class={accent === 'reef' && 'active'} onClick={() => (accent = 'reef')}>
					{'Reef'}
				</button>
				<button class={accent === 'sunset' && 'active'} onClick={() => (accent = 'sunset')}>
					{'Sunset'}
				</button>
				<button class={accent === 'forest' && 'active'} onClick={() => (accent = 'forest')}>
					{'Forest'}
				</button>
			</div>

			<div class="chart-wrap">
				if (chartType === 'line') {
					<Line {data} {options} height={380} />
				} else if (chartType === 'bar') {
					<Bar {data} {options} height={380} />
				} else if (chartType === 'radar') {
					<Radar {data} {options} height={380} />
				} else {
					<Pie {data} {options} height={380} />
				}
			</div>
		</section>
	</div>

	<style>
		:global(body) {
			margin: 0;
			font-family: 'IBM Plex Sans', 'Segoe UI', sans-serif;
			background: radial-gradient(circle at 18% 0%, #ecfeff, #e2e8f0 62%, #dbeafe);
		}

		.shell {
			min-height: 100vh;
			display: grid;
			place-items: center;
			padding: 1rem;
		}

		.panel {
			width: min(980px, 100%);
			background: linear-gradient(
				180deg,
				rgba(255, 255, 255, 0.9),
				rgba(248, 250, 252, 0.96)
			);
			border: 1px solid rgba(15, 23, 42, 0.1);
			border-radius: 18px;
			box-shadow: 0 20px 60px rgba(15, 23, 42, 0.16);
			padding: 1.25rem;
		}

		h1 {
			margin: 0;
			font-family: 'Fraunces', Georgia, serif;
			font-size: 1.8rem;
			letter-spacing: 0.02em;
			color: #0f172a;
		}

		.caption {
			margin: 0.45rem 0 1rem;
			color: #334155;
		}

		.toolbar,
		.row {
			display: flex;
			flex-wrap: wrap;
			gap: 0.55rem;
			margin: 0.7rem 0;
		}

		.controls {
			display: flex;
			flex-wrap: wrap;
			gap: 1rem;
			padding: 0.4rem 0;
		}

		label {
			display: inline-flex;
			align-items: center;
			gap: 0.45rem;
			font-size: 0.92rem;
			color: #1e293b;
		}

		button {
			border: 1px solid rgba(15, 23, 42, 0.18);
			background: #ffffff;
			color: #0f172a;
			font-family: 'IBM Plex Sans', 'Segoe UI', sans-serif;
			font-size: 0.9rem;
			padding: 0.45rem 0.8rem;
			border-radius: 10px;
			cursor: pointer;
			transition:
				transform 0.14s ease,
				border-color 0.14s ease,
				background 0.14s ease;
		}

		button:hover {
			transform: translateY(-1px);
		}

		button.active {
			border-color: var(--accent);
			background: color-mix(in srgb, var(--accent) 18%, #ffffff);
		}

		.chart-wrap {
			height: 420px;
			padding: 0.8rem;
			border: 1px solid rgba(15, 23, 42, 0.1);
			border-radius: 12px;
			background: #ffffff;
		}

		.accent-reef {
			--accent: #0891b2;
		}

		.accent-sunset {
			--accent: #ea580c;
		}

		.accent-forest {
			--accent: #16a34a;
		}

		@media (max-width: 700px) {
			.panel {
				padding: 1rem;
			}

			h1 {
				font-size: 1.45rem;
			}

			.chart-wrap {
				height: 360px;
			}
		}
	</style>
}
