# codra-docker

[![Travis Build Status](https://travis-ci.org/NLPbox/codra-docker.svg?branch=master)](https://travis-ci.org/NLPbox/codra-docker)
[![Docker Build Status](https://img.shields.io/docker/build/nlpbox/codra.svg)](https://hub.docker.com/r/nlpbox/codra/)

This docker container allows you to build, install and run the
[CODRA RST discourse parser](http://alt.qcri.org/tools/discourse-parser/)
(Joty et al. 2015) in a docker container.

## Building / Installing CODRA

```
git clone https://github.com/NLPbox/codra-docker
cd codra-docker
docker build -t codra .
```

## Running CODRA

To test if parser works, just run ``docker run codra``.
To run the parser on the file ``/tmp/input.txt`` on your
local machine, run:

```
docker run -v /tmp:/tmp -ti codra /tmp/input.txt
```

The input files should be encoded in UTF-8. Each sentence ending must
be marked with ``<s>`` and each paragraph ending with ``<p>``.


## Example Input

```
Henryk Szeryng (22 September 1918 - 8 March 1988) was a violin virtuoso 
of Polish and Jewish heritage.

He was born in Zelazowa Wola, Poland. Henryk started piano and harmony 
training with his mother when he was 5, and at age 7 turned to the 
violin, receiving instruction from Maurice Frenkel. After studies with 
Carl Flesch in Berlin (1929-32), he went to Paris to continue his 
training with Jacques Thibaud at the Conservatory, graduating with a 
premier prix in 1937.

He made his solo debut in 1933 playing the Brahms Violin Concerto. From 
1933 to 1939 he studied composition in Paris with Nadia Boulanger, and 
during World War II he worked as an interpreter for the Polish 
government in exile (Szeryng was fluent in seven languages) and gave 
concerts for Allied troops all over the world. During one of these 
concerts in Mexico City he received an offer to take over the string 
department of the university there.

In 1946, he became a naturalized citizen of Mexico.

Szeryng subsequently focused on teaching before resuming his concert 
career in 1954. His debut in New York City brought him great acclaim, 
and he toured widely for the rest of his life. He died in Kassel.

Szeryng made a number of recordings, including two of the complete 
sonatas and partitas for violin by Johann Sebastian Bach, and several 
of sonatas of Beethoven and Brahms with the pianist Arthur Rubinstein. 
He also composed; his works include a number of violin concertos and 
pieces of chamber music.

He owned the Del Gesu "Le Duc", the Stradivarius "King David" as well 
as the Messiah Strad copy by Jean-Baptiste Vuillaume which he gave to 
Prince Rainier III of Monaco. The "Le Duc" was the instrument on which 
he performed and recorded mostly, while the latter ("King David" Strad) 
was donated to the State of Israel.
```

## Example Output

```
( Root (span 1 43)
  ( Nucleus (span 1 4) (rel2par span)
    ( Nucleus (span 1 3) (rel2par span)
      ( Nucleus (span 1 2) (rel2par Same-Unit)
        ( Nucleus (leaf 1) (rel2par span) (text _!Henryk Szeryng_!) )
        ( Satellite (leaf 2) (rel2par Elaboration) (text _!( 22 September 1918 - 8 March 1988 )_!) )
       )
      ( Nucleus (leaf 3) (rel2par Same-Unit) (text _!was a violin virtuoso of Polish and Jewish heritage ._!) )
    )
    ( Satellite (leaf 4) (rel2par Elaboration) (text _!He was born in Zelazowa Wola , Poland ._!) )
  )
  ( Satellite (span 5 43) (rel2par Summary)
    ( Nucleus (span 5 8) (rel2par span)
      ( Nucleus (span 5 6) (rel2par Joint)
        ( Nucleus (leaf 5) (rel2par span) (text _!Henryk started piano and harmony training with his mother_!) )
        ( Satellite (leaf 6) (rel2par Elaboration) (text _!when he was 5 ,_!) )
       )
      ( Nucleus (span 7 8) (rel2par Joint)
        ( Nucleus (leaf 7) (rel2par span) (text _!and at age 7 turned to the violin ,_!) )
        ( Satellite (leaf 8) (rel2par Elaboration) (text _!receiving instruction from Maurice Frenkel ._!) )
       )
    )
    ( Satellite (span 9 43) (rel2par Elaboration)
      ( Nucleus (span 9 13) (rel2par span)
        ( Nucleus (span 9 10) (rel2par Same-Unit)
          ( Nucleus (leaf 9) (rel2par span) (text _!After studies with Carl Flesch in Berlin_!) )
          ( Satellite (leaf 10) (rel2par Elaboration) (text _!( 1929-32 ) ,_!) )
         )
        ( Nucleus (span 11 13) (rel2par Same-Unit)
          ( Nucleus (span 11 12) (rel2par span)
            ( Nucleus (leaf 11) (rel2par span) (text _!he went to Paris_!) )
            ( Satellite (leaf 12) (rel2par Enablement) (text _!to continue his training with Jacques Thibaud at the Conservatory ,_!) )
           )
          ( Satellite (leaf 13) (rel2par Evaluation) (text _!graduating with a premier prix in 1937 ._!) )
         )
      )
      ( Satellite (span 14 43) (rel2par Elaboration)
        ( Nucleus (span 14 28) (rel2par span)
          ( Nucleus (span 14 20) (rel2par span)
            ( Nucleus (span 14 15) (rel2par span)
              ( Nucleus (leaf 14) (rel2par span) (text _!He made his solo debut in 1933_!) )
              ( Satellite (leaf 15) (rel2par Elaboration) (text _!playing the Brahms Violin Concerto ._!) )
            )
            ( Satellite (span 16 20) (rel2par Elaboration)
              ( Nucleus (span 16 17) (rel2par Joint)
                ( Nucleus (leaf 16) (rel2par span) (text _!From 1933 to 1939_!) )
                ( Satellite (leaf 17) (rel2par Elaboration) (text _!he studied composition in Paris with Nadia Boulanger ,_!) )
               )
              ( Nucleus (span 18 20) (rel2par Joint)
                ( Nucleus (span 18 19) (rel2par Same-Unit)
                  ( Nucleus (leaf 18) (rel2par span) (text _!and during World War II he worked as an interpreter for the Polish government in exile_!) )
                  ( Satellite (leaf 19) (rel2par Elaboration) (text _!( Szeryng was fluent in seven languages )_!) )
                 )
                ( Nucleus (leaf 20) (rel2par Same-Unit) (text _!and gave concerts for Allied troops all over the world ._!) )
               )
            )
          )
          ( Satellite (span 21 28) (rel2par Explanation)
            ( Nucleus (span 21 25) (rel2par span)
              ( Nucleus (span 21 23) (rel2par span)
                ( Satellite (leaf 21) (rel2par Background) (text _!During one of these concerts in Mexico City_!) )
                ( Nucleus (span 22 23) (rel2par span)
                  ( Nucleus (leaf 22) (rel2par span) (text _!he received an offer_!) )
                  ( Satellite (leaf 23) (rel2par Elaboration) (text _!to take over the string department of the university there ._!) )
                 )
              )
              ( Satellite (span 24 25) (rel2par Elaboration)
                ( Satellite (leaf 24) (rel2par Background) (text _!In 1946 ,_!) )
                ( Nucleus (leaf 25) (rel2par span) (text _!he became a naturalized citizen of Mexico ._!) )
              )
            )
            ( Satellite (span 26 28) (rel2par Elaboration)
              ( Nucleus (leaf 26) (rel2par span) (text _!Szeryng subsequently focused on teaching before resuming his concert career in 1954 ._!) )
              ( Satellite (span 27 28) (rel2par Elaboration)
                ( Nucleus (leaf 27) (rel2par Joint) (text _!His debut in New York City brought him great acclaim ,_!) )
                ( Nucleus (leaf 28) (rel2par Joint) (text _!and he toured widely for the rest of his life ._!) )
              )
            )
          )
        )
        ( Satellite (span 29 43) (rel2par Elaboration)
          ( Nucleus (span 29 32) (rel2par Joint)
            ( Nucleus (leaf 29) (rel2par span) (text _!He died in Kassel ._!) )
            ( Satellite (span 30 32) (rel2par Explanation)
              ( Nucleus (span 30 31) (rel2par Joint)
                ( Nucleus (leaf 30) (rel2par span) (text _!Szeryng made a number of recordings ,_!) )
                ( Satellite (leaf 31) (rel2par Elaboration) (text _!including two of the complete sonatas and partitas for violin by Johann Sebastian Bach ,_!) )
               )
              ( Nucleus (leaf 32) (rel2par Joint) (text _!and several of sonatas of Beethoven and Brahms with the pianist Arthur Rubinstein ._!) )
            )
          )
          ( Nucleus (span 33 43) (rel2par Joint)
            ( Nucleus (span 33 37) (rel2par span)
              ( Nucleus (span 33 34) (rel2par span)
                ( Nucleus (leaf 33) (rel2par span) (text _!He also composed ;_!) )
                ( Satellite (leaf 34) (rel2par Elaboration) (text _!his works include a number of violin concertos and pieces of chamber music ._!) )
              )
              ( Satellite (span 35 37) (rel2par Elaboration)
                ( Nucleus (leaf 35) (rel2par span) (text _!He owned the Del Gesu \\\" Le Duc \\\" , the Stradivarius \\\" King David \\\" as well as the Messiah Strad copy_!) )
                ( Satellite (span 36 37) (rel2par Manner-Means)
                  ( Nucleus (leaf 36) (rel2par span) (text _!by Jean-Baptiste Vuillaume_!) )
                  ( Satellite (leaf 37) (rel2par Elaboration) (text _!which he gave to Prince Rainier III of Monaco ._!) )
                 )
              )
            )
            ( Satellite (span 38 43) (rel2par Elaboration)
              ( Nucleus (span 38 42) (rel2par Same-Unit)
                ( Nucleus (leaf 38) (rel2par span) (text _!The \\\" Le Duc \\\" was the instrument_!) )
                ( Satellite (span 39 42) (rel2par Elaboration)
                  ( Nucleus (span 39 40) (rel2par Contrast)
                    ( Nucleus (leaf 39) (rel2par Joint) (text _!on which he performed_!) )
                    ( Nucleus (leaf 40) (rel2par Joint) (text _!and recorded mostly ,_!) )
                   )
                  ( Nucleus (span 41 42) (rel2par Contrast)
                    ( Nucleus (leaf 41) (rel2par span) (text _!while the latter_!) )
                    ( Satellite (leaf 42) (rel2par Elaboration) (text _!( \\\" King David \\\" Strad )_!) )
                   )
                 )
               )
              ( Nucleus (leaf 43) (rel2par Same-Unit) (text _!was donated to the State of Israel ._!) )
            )
          )
        )
      )
    )
  )
)
```

# Citation

Shafiq Joty and Giuseppe Carenini and Raymond T. Ng (2015).
[CODRA: A Novel Discriminative Framework for Rhetorical Analysis](http://www.mitpressjournals.org/doi/pdf/10.1162/COLI_a_00226)
Computational Linguistics Volume 41, Number 3, 385-435.
