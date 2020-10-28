from sys import argv
from os import listdir
import os.path as path
import json

def compile_JSONs_to_CSV(inFolder, outFile, *, debug = False, remove_followless = False,
        min_ratings = 0):
    acc = []
    items = [i for i in listdir(inFolder) if i.find(".json") >= 0]

    for i in items:
        print(i)
        curr = None
        with open(path.join(inFolder, i), "r") as f_in:
            curr = json.load(f_in)
        for j in curr.keys():
            manga = curr[j]
            idx = int(j)
            chapter_comments = 0
            if "chapter" in manga:
                chapters = manga["chapter"]
                for k in chapters.keys():
                    num = chapters[k]["comments"]
                    chapter_comments += 0 if num == None else int(num)
            if (manga["status"] == "OK"
                and (not remove_followless or int(manga["manga"]["follows"]) > 0)
                and (int(manga["manga"]["rating"]["users"].replace(",", "")) >= min_ratings)):
                acc.append([
                    idx,
                    int(manga["manga"]["views"]),
                    float(manga["manga"]["rating"]["mean"]),
                    float(manga["manga"]["rating"]["bayesian"]),
                    int(manga["manga"]["rating"]["users"].replace(",", "")),
                    int(manga["manga"]["follows"]),
                    (lambda n: 0 if n == None else int(n))(manga["manga"]["comments"]),
                    chapter_comments,
                    ("\"" + manga["manga"]["title"] + "\"").encode("unicode_escape")])

    acc.sort(key = lambda x: x[0])

    with open(outFile, "w") as f_out:
        f_out.write("id,views,mean_rating,bayesian_rating,ratings,")
        f_out.write("follows,manga_comments,chapter_comments,title\n")

        for i in acc:
            i[8] = str(i[8])[3:-2]
            f_out.write(f"{','.join([str(j) for j in i])}\n")

