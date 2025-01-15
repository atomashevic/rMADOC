# rMADOC

R package to easily to download and combine parts of MADOC dataset from Zenodo. The MADOC dataset contains social media posts from multiple platforms (Reddit, Voat, Bluesky, and Koo), making it easy to study cross-platform content and community dynamics.

## Installation

You can install the package directly from GitHub:

```r
# install.packages("devtools")
devtools::install_github("atomashevic/rMADOC")
```

## Usage

### List Available Data

To see what data is available in the MADOC dataset:

```r
library(rMADOC)
list_available_data()
```

This will show you all available platforms and communities, along with their file sizes.

### Download Individual Files

There are two ways to download files:

1. Save to disk and load later (recommended, especially for Reddit data):
```r
# Download and save files
filename <- download_file("reddit", "gaming", output_dir = "data")

# Load the downloaded file later when needed
df <- load_local(filename)
```

2. Load directly into memory (suitable for smaller files like Voat, Bluesky, or Koo):
```r
# Load Bluesky data directly as a data.frame
bluesky_df <- download_file("bluesky", as_dataframe = TRUE)

# Load Voat gaming data directly (small file)
voat_gaming_df <- download_file("voat", "gaming", as_dataframe = TRUE)
```

**Note**: Direct memory loading (`as_dataframe = TRUE`) is not recommended for Reddit data as some communities have very large file sizes (up to 9GB). For Reddit data, always download to disk first and then load the files as needed.

### Download and Combine Community Pairs

You can download and combine Reddit-Voat pairs for the same community:

1. Save to disk and load later (recommended):
```r
# Download both files
files <- download_community_pair("gaming", output_dir = "data")

# Load them later when needed
reddit_df <- load_local(files$reddit_file)
voat_df <- load_local(files$voat_file)
```

2. Load directly into memory (not recommended for most communities due to Reddit file sizes):
```r
# Only use this for communities with smaller file sizes
combined_df <- download_community_pair("gaming", as_dataframe = TRUE)
```

## Available Data

### Standalone Platforms
- Bluesky (~449.3 MB)
- Koo (~774.3 MB)

### Communities (available on both Reddit and Voat)
- CringeAnarchy (Reddit: 951.7 MB, Voat: 476.2 KB)
- fatpeoplehate (Reddit: 214.5 MB, Voat: 61.9 MB)
- funny (Reddit: 9.1 GB, Voat: 18.8 MB)
- gaming (Reddit: 7.2 GB, Voat: 12.7 MB)
- gifs (Reddit: 3.1 GB, Voat: 2.8 MB)
- greatawakening (Reddit: 179.3 MB, Voat: 76.1 MB)
- KotakuInAction (Reddit: 1.5 GB, Voat: 1.8 MB)
- MensRights (Reddit: 797.8 MB, Voat: 792.6 KB)
- milliondollarextreme (Reddit: 170.2 MB, Voat: 3.5 MB)
- pics (Reddit: 8.3 GB, Voat: 5.3 MB)
- technology (Reddit: 2.5 GB, Voat: 15.2 MB)
- videos (Reddit: 6.5 GB, Voat: 102.4 KB)

As you can see, Reddit files are significantly larger than their Voat counterparts. Use `list_available_data()` to see this information in a formatted table.

## Features

- Option to load data directly into memory or save to disk
- Helper function to load saved parquet files
- Progress bars with download speed
- Support for both individual platform downloads and Reddit-Voat community pairs
- Automatic file size verification
- Human-readable file size formatting

## Dependencies

- arrow (for parquet file support)
- dplyr
- curl
- utils


## Citation

If you use this package or the MADOC dataset in your research, please cite:

Mitrovic Dankulov, M., Tomašević, A., Maletic, S., Andjelkovic, M., Vranic, A., Cvetkovic, D., Stupovski, B., Vudragovic, D., Major, S., & Bogojević, A. (2025). MADOC: Multi-Platform Aggregated Dataset of Online Communities (1.0.0) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14637314

Or BibTeX:

```
@MISC{mitrovicDankulov2025madoc,
  title     = "MADOC: Multi-Platform Aggregated Dataset of Online Communities",
  author    = "Mitrovic Dankulov, Marija and Tomašević, Aleksandar and Maletic,
               Slobodan and Andjelkovic, Miroslav and Vranic, Ana and Cvetkovic,
               Darja and Stupovski, Boris and Vudragovic, Dusan and Major, Sara
               and Bogojević, Aleksandar",
  publisher = "Zenodo",
  abstract  = "The Multi-platform Aggregated Dataset of Online Communities
               (MADOC) is a comprehensive dataset that facilitates computational
               social science research by providing a unified, standardized
               dataset for cross-platform analysis of online social dynamics.
               MADOC aggregates and standardizes data from four distinct
               platforms: Bluesky, Koo, Reddit, and Voat, spanning from 2012 to
               2024. The dataset includes 18.9 million posts, 236 million
               comments, and data from 23.1 million unique users across all
               platforms, with a particular focus on understanding community
               dynamics, user migration patterns, and the evolution of toxic
               behavior across platforms. By providing standardized data
               structures and FAIR-compliant access through Zenodo, MADOC
               enables researchers to conduct comparative analyses of user
               behavior, interaction networks, and content sentiment across
               diverse social media environments. The dataset's unique value
               lies in its cross-platform scope, standardized structure, and
               rich metadata, making it particularly suitable for studying
               societal phenomena such as community formation, toxic behavior
               propagation, and user migration patterns in response to platform
               moderation policies.",
  year      =  2025,
  url       = "https://zenodo.org/records/14637314",
  keywords  = "Social Media; Online Social Networking; Social Network Analysis",
  doi       = "10.5281/ZENODO.14637314"
}

```



## License

MIT
