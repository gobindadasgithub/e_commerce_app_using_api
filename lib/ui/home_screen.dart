import 'package:e_commerce_shop_api/controller/api_controller.dart';
import 'package:e_commerce_shop_api/model/articile_modle.dart';
import 'package:e_commerce_shop_api/ui/aritcile_screen.dart';
import 'package:e_commerce_shop_api/ui/components/categoryIteam.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _value=0;
  List<String>  Categorietitle=[
    "All",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Hello Fashioner',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: const BoxDecoration(

              image: DecorationImage(
                image: AssetImage(
                  "assets/images/svgviewer-png-output.png"
                ),
                fit: BoxFit.contain
              )
            ),


          ),
          const SizedBox(
            height: 20,
          ),
          Container(

            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,


                child: Row(
                  children: List.generate(Categorietitle.length, (index) {
                    return MyRadioListTile(
                        value: index,
                        groupValue: _value,
                        leading: Categorietitle[index],
                        onChanged: (value){
                          setState(() {
                            _value=value!;
                          });
                        });
                  }),
                  

                ),
              ),
            ),

          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<List<Article>>(
            future: _value==0 ?
                ApiControll.fatchArticle():
                ApiControll.fetchArticleByCategorie(Categorietitle.toString())
              ,

              builder: (context,snapshot){
              return snapshot.hasData ?
                  Expanded(
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 2
                          ),
                          itemBuilder: (BuildContext context,int index){
                            return InkWell(
                              onTap: ((){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                        articalID:
                                        snapshot.data![index].id!,
                                        )));
                                
                              }
                              
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data![index].image!),
                                              fit: BoxFit.contain)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].id!.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '\$${snapshot.data![index].price}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Color.fromARGB(
                                            255, 253, 104, 104),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),


                            );

                          }),
                    ),
                  )
                  : const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));


              }

              )



        ],
      ),

    );
  }
}
