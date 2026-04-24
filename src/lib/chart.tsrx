import { Chart as ChartJS } from 'chart.js';
import type { ChartType, DefaultDataPoint } from 'chart.js';
import type { ChartProps } from './types';
import { effect, track, untrack, type Tracked } from 'ripple';
import { cloneData } from './utils';
import { setOptions, setDatasets, setLabels, resolveMaybeTracked } from './utils';

function watch(deps: Array<Tracked<any>>, cb: () => void) {
	let first = true;

	effect(() => {
		deps.forEach((dep) => dep.value);

		if (first) {
			first = false;

			return;
		}

		return untrack(cb);
	});
}

export component Chart(props: ChartProps<ChartType, DefaultDataPoint<ChartType>>) {
	const canvasNode = track<HTMLCanvasElement | null>(null);
	let &[chart] = track<ChartJS | null>(null);
	const type = track(() => props.type);
	const data = track(() => props.data);
	const options = track(() => props.options);
	const plugins = track(() => props.plugins);
	const datasets = track(() => resolveMaybeTracked(data).datasets);
	const labels = track(() => resolveMaybeTracked(data).labels);

	const renderChart = () => {
		if (!canvasNode.value) {
			return;
		}

		chart = new ChartJS(canvasNode.value, {
			type: resolveMaybeTracked(type),
			data: cloneData(resolveMaybeTracked(data), props.datasetIdKey),
			options: resolveMaybeTracked(options) &&
				{
					...resolveMaybeTracked(options),
				},
			plugins: resolveMaybeTracked(plugins),
		});
	};

	const destroyChart = () => {
		if (chart) {
			chart.destroy();
			chart = null;
		}
	};

	watch([options], () => {
		const nextOptions = resolveMaybeTracked(options);

		if (!props.redraw && chart && nextOptions) {
			setOptions(chart, nextOptions);
		}
	});

	watch([labels], () => {
		const nextLabels = resolveMaybeTracked(labels);

		if (!props.redraw && chart) {
			setLabels(chart.config.data, nextLabels);
		}
	});
	watch([datasets], () => {
		const nextDatasets = resolveMaybeTracked(datasets);

		if (!props.redraw && chart && nextDatasets) {
			setDatasets(chart.config.data, nextDatasets, props.datasetIdKey);
		}
	});
	watch([options, datasets, labels], () => {
		if (!chart) {
			return;
		}

		if (props.redraw) {
			destroyChart();
			setTimeout(renderChart);
		} else {
			chart.update(props.updateMode);
		}
	});
	watch([type], () => {
		destroyChart();
		renderChart();
	});
	effect(() => {
		untrack(renderChart);

		return destroyChart;
	});

	<canvas
		{ref (node) => {
			canvasNode.value = node;

			return () => (canvasNode.value = null);
		}}
		role="img"
		height={props.height}
		width={props.width}
	/>
}
