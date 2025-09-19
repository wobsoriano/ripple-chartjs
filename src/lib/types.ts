import type {
	ChartType,
	ChartData,
	ChartOptions,
	DefaultDataPoint,
	Plugin,
	UpdateMode,
} from 'chart.js';
import type { Component, Tracked } from 'ripple';

export interface ChartProps<
	TType extends ChartType = ChartType,
	TData = DefaultDataPoint<TType>,
	TLabel = unknown,
	// > extends CanvasHTMLAttributes<HTMLCanvasElement> {
> {
	/**
	 * Chart.js chart type
	 */
	type: Tracked<TType>;
	/**
	 * The data object that is passed into the Chart.js chart
	 * @see https://www.chartjs.org/docs/latest/getting-started/
	 */
	data: Tracked<ChartData<TType, TData, TLabel>>;
	/**
	 * The options object that is passed into the Chart.js chart
	 * @see https://www.chartjs.org/docs/latest/general/options.html
	 * @default {}
	 */
	options?: Tracked<ChartOptions<TType>>;
	/**
	 * The plugins array that is passed into the Chart.js chart
	 * @see https://www.chartjs.org/docs/latest/developers/plugins.html
	 * @default []
	 */
	plugins?: Tracked<Plugin<TType>[]>;
	/**
	 * Teardown and redraw chart on every update
	 * @default false
	 */
	redraw?: boolean;
	/**
	 * Key name to identificate dataset
	 * @default 'label'
	 */
	datasetIdKey?: string;
	/**
	 * A mode string to indicate transition configuration should be used.
	 * @see https://www.chartjs.org/docs/latest/developers/api.html#update-mode
	 */
	updateMode?: UpdateMode;
}

export type TypedChartProps<TType extends ChartType = ChartType, TData = DefaultDataPoint<TType>, TLabel = unknown> = Omit<ChartProps<TType, TData, TLabel>, 'type'>;