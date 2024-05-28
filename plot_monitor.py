import os
import sys
import pandas as pd
from bokeh.plotting import figure, output_file, save
from bokeh.io import export_svg

def plot_monitor_data(monitor_csv_path, plot_dir):
    # Read monitor file
    monitor_data = pd.read_csv(monitor_csv_path)
    monitor_data['Time'] = pd.to_datetime(monitor_data['Time'])

    # Create Bokeh plot
    p = figure(x_axis_type='datetime', title='System Monitoring Data')
    p.line(x='Time', y='CPU', legend_label='CPU (%)', line_color='blue', source=monitor_data)
    p.line(x='Time', y='Memory', legend_label='Memory (%)', line_color='red', source=monitor_data)
    p.xaxis.axis_label = 'Time'
    p.yaxis.axis_label = 'Percentage (%)'

    # Create directory if it doesn't exist
    os.makedirs(plot_dir, exist_ok=True)

    # Get the parent folder name of the monitor file
    parent_folder = os.path.basename(os.path.dirname(monitor_csv_path))

    output_html_file = os.path.join(plot_dir, f'{parent_folder}_monitor_plot.html')
    output_svg_file = os.path.join(plot_dir, f'{parent_folder}_monitor_plot.svg')

    output_file(output_html_file)
    save(p)
    p.output_backend = "svg"
    export_svg(p, filename=output_svg_file)

    

def find_monitor_csv(directory):
    monitor_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file == 'monitor.csv':
                monitor_files.append(os.path.join(root, file))
    return monitor_files

# Example usage
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory>")
        sys.exit(1)

    directory = sys.argv[1]
    plot_dir = "plot"
    monitor_csv_paths = find_monitor_csv(directory)
    if not monitor_csv_paths:
        print("No 'monitor.csv' files found.")
    else:
        for monitor_csv_path in monitor_csv_paths:
            plot_monitor_data(monitor_csv_path, plot_dir)
