# UCL MSc Data Science & Machine Learning Thesis

In this repo lives all the code used for the computational work as part of my
masters' thesis.

---

### Two Little Birds: A Study in Birdsong Binary Classification Problems

Automated or semi-automated birdsong classification plays a key role in a
wide range of important fields, such as ecological surveying, climate modelling,
and birdwatching for pleasure. With a recent surge in popularity of machine
learning techniques and a wealth of of publicly available datasets, these
problems are increasingly being tackled using state-of-the-art machine learning
approaches with better and better results. This work will focus on investigating
and evaluating popular approaches to birdsong classification problems, as well
as experimenting with recent research into wider audio classification problems
and evaluating them in a birdsong context.

## Layout

The following sections describe the schematic of this repo and the contents of
each directory.

#### experiments/

A collection of live scripts used to generate the results for each hypothesis.
Each script handles preparing the feature representation of the training input
and formatting it into the correct structure for the model at hand, as well as
training the model and evaluating it against the test set. The results are
stored in a cell array and saved for posterity. All code therein is my own work.

#### figures/

A directory of saved figures used in the report.

#### report/

All the LaTeX code used writing the report.

#### samples/

A directory of audio recordings used for this work, both the raw recordings
downloaded from [xeno-canto](xeno-canto.org) and the syllables extracted from
the recordings. Note that this directory is git-ignored due to its size. The
folder of noise recordings was downloaded with the intention of adding noise to
the birdsong samples but this was never used.

#### tools/

A folder of MATLAB functions developed for this thesis. The following table
lists the most important functions used in this work in more detail:

|Name|Description|Custom?|References|
|---|---|---|---|
|`cochleagram.m`|Generate a cochleagram from the output of a gammatone filterbank|❌|Copied from [^fn1]|
|`createSequences.m`|Generate a sequence of samples from the syllables extracted from birdsong samples|✅||
|`evaluate{NN,RNN,SVM}.m`|Evaluate a trained neural network, recurrent neural network, and SVM model respectively for AUC and accuracy|✅||
|`mono.m`|Convert a stereo signal to mono|✅|
|`mrcg.m`|Generate an MRCG feature from the output of a gammatone filterbank|❌|Adapted from [^fn1]|
|`retreiveSamples.m`|Retrieve syllables saved on disk and optionally append a given number of following syllables to each syllable. Used for generating samples for RNN.|✅||
|`segmentSyllables.m`|Extract the syllables from a given input signal|✅|Algorithm described in [^fn2]|
|`stripSound.m`|Strip leading and training bits of background noise from an input signal|✅||

#### tutorials/

Some initial experimentation work to get up to speed with the field. None of the
output from this directory was used in the final report.

#### variables/

A directory of saved MATLAB variables.

#### work/

A collection of live scripts for the pilot and feasibility studies. Very few
scripts were used in their entirety for the final report but many provided the
foundation work for the hypotheses experiments and were rewritten into cleaner
scripts stored in the `experiments/` directory. All scripts are my own work. The
`addSyllableSamples.mlx` script was used to generate extract the syllables from
raw recordings and store them on disk to be used later. The `figureWork.mlx` is
a script dedicated for generating figures used in the final report.

[^fn1]: Kim, Juntae, and Minsoo Hahn. "Voice activity detection using an
  adaptive context attention model." IEEE Signal Processing Letters 25.8 (2018):
  1181-1185.

[^fn2]: Fagerlund, Seppo. "Automatic recognition of bird species by their
  sounds." Finlandia: Helsinki University Of Technology (2004).
