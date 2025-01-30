#!/opt/homebrew/bin/fish

# ---------------------------------------------------------------------------
# Print usage if missing parameter
# ---------------------------------------------------------------------------
if test (count $argv) -eq 0
    echo -e "\n[ Usage ]\n\n./get_subscript.sh <audio_file>\n"
    exit 1
end

# ---------------------------------------------------------------------------
# Print usage if missing parameter
# ---------------------------------------------------------------------------
function process_file -d "Convert input audio format and throw into 'whisper-cpp' to extract the transcript."
    # echo "[ process_file ] $argv[1]"

    #
    # Set input and output files
    #
    set --local input_file $argv[1]
    echo -e ">>> input_file: $input_file"

    set --local output_dir "$HOME/Desktop/scripts"
    set --local basename $(basename "$input_file" | sed 's/\.[^.]*$//')  # File name without extension
    set --local temporary_wave_file "$output_dir/$basename.wav"

    #
    # Create the output folder if it doesn't exist
    #
    mkdir -p "$output_dir"

    #
    # Convert input audio file to the specified wav format that `whisper-cpp`
    # asks for.
    #
    ffmpeg -i $input_file \
        -ar 16000 -ac 1 -c:a pcm_s16le \
        $temporary_wave_file \
        2> /dev/null > /dev/null
    echo -e ">>> Convert wav format done."

    #
    # Extract text
    echo -e ">>> Extracting text......\n"
    cd ~/temp/whisper.cpp && ./build/bin/whisper-cli \
        --threads 8 \
        --output-txt \
        --no-prints \
        -f "$temporary_wave_file"
    echo -e ">>> Extract text done.\n"

    #
    # Delete the temporary converted wave file
    #
    rm -rf "$temporary_wave_file"
end

# ---------------------------------------------------------------------------
# Call `process_file` based on different situations
# ---------------------------------------------------------------------------
if test -f $argv[1]
    # echo ">>> file: $argv"
    process_file $argv[1]
else if test -d $argv[1]
    for filename in "$argv[1]"/*.mp4
        # echo ">>> filename: $filename"
        process_file $filename
    end
else
    echo -e "\n Invalid input. Provide an audio file or a directory."
    exit 1
end
