<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BlackJack</title>
    <link href="/blackjack/css/game.css" rel="stylesheet">
    <script src="/blackjack/js/jquery.js"></script>
</head>
<body>

<script>
    var isBegin = false;
    var canDeal = false;
    var canHit = false;
    var jsonData;
    $(document).ready(function () {
        function transfer(suit, point) {
            var numberToString;
            switch (point) {
                case '1':
                    numberToString = 'one';
                    break;
                case '2':
                    numberToString = 'two';
                    break;
                case '3':
                    numberToString = 'three';
                    break;
                case '4':
                    numberToString = 'four';
                    break;
                case '5':
                    numberToString = 'five';
                    break;
                case '6':
                    numberToString = 'six';
                    break;
                case '7':
                    numberToString = 'seven';
                    break;
                case '8':
                    numberToString = 'eight';
                    break;
                case '9':
                    numberToString = 'nine';
                    break;
                case '10':
                    numberToString = 'ten';
                    break;
                default:
                    numberToString = point;
            }

            return suit + '-' + numberToString;
        }

        function getCardsAOrCardsB(suit,point) {
            var cardPicuture = 'cardsB';
            switch (suit){
                case 'spade':
                    cardPicuture = 'cardsA';
                    break;
                case 'clubs':
                    cardPicuture = 'cardsA';
                    break;
                case 'heart':
                    switch (point){
                        case '1':
                            cardPicuture = 'cardsA';
                            break;
                        case '2':
                            cardPicuture = 'cardsA';
                            break;
                        case '3':
                            cardPicuture = 'cardsA';
                            break;
                        case '4':
                            cardPicuture = 'cardsA';
                            break;
                        case '5':
                            cardPicuture = 'cardsA';
                            break;
                        case '6':
                            cardPicuture = 'cardsA';
                            break;
                        case '7':
                            cardPicuture = 'cardsA';
                            break;
                        case '8':
                            cardPicuture = 'cardsA';
                            break;
                        case '9':
                            cardPicuture = 'cardsA';
                            break;
                    }
                    break;
                default:
                    cardPicuture = 'cardsB';
            }
            return cardPicuture;
        }

        $('#deal').on('click', function () {
            if (!isBegin&&!canDeal) {
                canDeal = true;

                //清除牌堆和win-lose结果
                $('.cardsB-block').remove();
                $('.cardsA-block').remove();
                $('.over-word-block').remove();

                var bet = $('#bet').text().trim();
                $.ajax({

                    url: '/blackjack/deal',
                    data: {
                        "sessionId": '${sessionId}',
                    },
                    type: 'get',
                    dataType: "json",
                    success: function (result) {
                        jsonData = result;
                        //一.发牌
                        //1.从jsonData中获取dealer的两张牌, 其中第一张为暗牌, 第二张为明牌
                        var suit = jsonData.dealerCard[0].suit;
                        var point = jsonData.dealerCard[0].point;
                        var dealerCssName0 = transfer(suit, point);
                        var dealerCardsChoose0 = getCardsAOrCardsB(suit,point);
                        //2.从jsonData中获取player的两张牌,两张均为名牌


                        var suit = jsonData.playerCard[0].suit;
                        var point = jsonData.playerCard[0].point;
                        var playerCssName0 = transfer(suit, point);
                        var playerCardsChoose0 = getCardsAOrCardsB(suit,point);
                        //3.实现动画1:->从牌堆中同时发出dealer和player第一张牌,两张均翻转
                        $('.bet-score').before("<div class=\"cardsA-block\" id=\"dealer0\">\n" +
                                "            <div class=\"cardsB\" id='dealer0-card-picture'>\n" +
                                "                <div class=\"card-back\" id='dealer0-card'></div>\n" +
                                "            </div>\n" +
                                "        </div>");

                        $('#dealer0').animate({left:'600px'},2000,function () {
                            var currentCardPicture = $('#dealer0-card-picture').attr('class');
                            $('#dealer0-card-picture').removeClass(currentCardPicture);
                            $('#dealer0-card-picture').addClass(dealerCardsChoose0);

                            var currentCardCss = $('#dealer0-card').attr('class');
                            $('#dealer0-card').removeClass(currentCardCss);
                            $('#dealer0-card').addClass(dealerCssName0);

                            //4.实现动画2:->从牌堆中同时发出dealer和player第一张牌,dealer为暗牌,player为明牌
                            var suit = jsonData.dealerCard[1].suit;
                            var point = jsonData.dealerCard[1].point;
                            var dealerCssName1 = transfer(suit, point);
                            var dealerCardsChoose1 = getCardsAOrCardsB(suit,point);

                            //添加dealer的第二张牌
                            $('.bet-score').before("<div class=\"cardsA-block\" id=\"dealer1\">\n" +
                                    "            <div class=\"cardsB\" id='dealer1-card-picture'>\n" +
                                    "                <div class=\"card-back\" id='dealer1-card'></div>\n" +
                                    "            </div>\n" +
                                    "        </div>");

                            $('#dealer1').animate({left:'670px'},2000,function () {
                                // var currentCardPicture = $('#dealer2-card-picture').attr('class');
                                // $('#dealer2-card-picture').removeClass(currentCardPicture);
                                // $('#dealer2-card-picture').addClass(dealerCardsChoose2);
                                // console.log(dealerCardsChoose2);
                                // var currentCardCss = $('#dealer2-card').attr('class');
                                // $('#dealer2-card').removeClass(currentCardCss);
                                // $('#dealer2-card').addClass(dealerCssName2);
                            });
                        });


                        $('.bet-score').before("<div class=\"cardsB-block\" id='player0'>\n" +
                                "    <div class=\"cardsB\" id='player0-card-picture'>\n" +
                                "    <div class=\"card-back\" id='player0-card'></div>\n" +
                                "    </div>\n" +
                                "    </div>");

                        $('#player0').animate({left:'600px',top:'350px'},2000,function () {
                            var currentCardPicture = $('#player0-card-picture').attr('class');
                            $('#player0-card-picture').removeClass(currentCardPicture);
                            $('#player0-card-picture').addClass(playerCardsChoose0);

                            var currentCardCss = $('#player0-card').attr('class');
                            $('#player0-card').removeClass(currentCardCss);
                            $('#player0-card').addClass(playerCssName0);


                            var suit = jsonData.playerCard[1].suit;
                            var point = jsonData.playerCard[1].point;
                            var playerCssName1 = transfer(suit, point);

                            var playerCardsChoose1 = getCardsAOrCardsB(suit,point);

                            $('.bet-score').before("<div class=\"cardsB-block\" id='player1'>\n" +
                                    "    <div class=\"cardsB\" id='player1-card-picture'>\n" +
                                    "    <div class=\"card-back\" id='player1-card'></div>\n" +
                                    "    </div>\n" +
                                    "    </div>");

                            $('#player1').animate({left:'670px',top:'350px'},2000,function () {
                                var currentCardPicture = $('#player1-card-picture').attr('class');
                                $('#player1-card-picture').removeClass(currentCardPicture);
                                $('#player1-card-picture').addClass(playerCardsChoose1);

                                var currentCardCss = $('#player1-card').attr('class');
                                $('#player1-card').removeClass(currentCardCss);
                                $('#player1-card').addClass(playerCssName1);

                                isBegin = true;
                                canHit = true;
                            });
                        });









                    }
                });
                //点击之后设置透明度
                $('.button-deal').css({opacity: 0.5});
                $('.button-2x').css({opacity: 0.5});
                $('.button-stand').css({opacity: 1});
                $('.button-hit').css({opacity: 1});
                //点击之后,以下按钮都会不可点击
                $('.button-deal').css("cursor", "default");
                $('.button-2x').css("cursor", "default");
                $('.button-x20').css("cursor", "default");
                $('.button-x100').css("cursor", "default");
                $('.button-x500').css("cursor", "default");
                $('.button-x1k').css("cursor", "default");

                //点击之后,以下按钮都会变成可点击的
                $('.button-stand').css("cursor", "pointer");
                $('.button-hit').css("cursor", "pointer");
                return false;
            }
        })


        $('#button-2x').on('click', function () {
            if (!isBegin) {
                var number = $('#bet').text().trim() * 2;
                if (number >= 100000) {
                    $('.bet-score').css("left", "750px");
                } else if (number >= 10000) {
                    $('.bet-score').css("left", "755px");
                } else if (number >= 1000) {
                    $('.bet-score').css("left", "760px");
                } else if (number >= 100) {
                    $('.bet-score').css("left", "765px");
                }
                $('#bet').text(number);
            }
        });

        $('#button-x20').on('click', function () {
            if (!isBegin) {
                $('.bet-score').css("left", "770px");
                $('#bet').text(20);
            }

        });

        $('#'+'button-x100').on('click', function () {
            if (!isBegin) {
                $('.bet-score').css("left", "765px");
                $('#bet').text(100);
            }
        });

        $('#button-x500').on('click', function () {
            if (!isBegin) {
                $('.bet-score').css("left", "765px");
                $('#bet').text(500);
            }
        });

        $('#button-x1k').on('click', function () {
            if (!isBegin) {
                $('.bet-score').css("left", "760px");
                $('#bet').text(1000);
            }

        });

        $('#button-stand').on('click', function () {
            if (isBegin){
                isBegin = false;
                $.ajax({

                    url: '/blackjack/stand',
                    data: {
                        "sessionId": '${sessionId}',
                    },
                    type: 'get',
                    dataType: "json",
                    success: function (result) {

                        var suit = jsonData.dealerCard[1].suit;
                        var point = jsonData.dealerCard[1].point;
                        var dealerCssName1 = transfer(suit, point);
                        var dealerCardsChoose1 = getCardsAOrCardsB(suit,point);
                        //翻开庄家的第二张牌
                        var currentCardPicture = $('#dealer1-card-picture').attr('class');
                        $('#dealer1-card-picture').removeClass(currentCardPicture);
                        $('#dealer1-card-picture').addClass(dealerCardsChoose1);

                        var currentCardCss = $('#dealer1-card').attr('class');
                        $('#dealer1-card').removeClass(currentCardCss);
                        $('#dealer1-card').addClass(dealerCssName1);

                        //如果dealer

                        //如果有第三张牌或更多,则实现发牌动画
                        var i = 2;
                        var prefix = 'dealer';
                        prefix = prefix + i;
                        MyAnimateDealer(i,result,prefix);

                        function MyAnimateDealer(i,result,prefix) {
                            if (result.dealerCard.length==2){
                                gameover(result);
                                return;
                            }


                            var suit = result.dealerCard[i].suit;
                            var point = result.dealerCard[i].point;
                            var dealerCssName = transfer(suit, point);
                            var dealerCardsChoose = getCardsAOrCardsB(suit,point);

                            $('.bet-score').before("<div class=\"cardsB-block\" id='"+prefix+"'>\n" +
                                    "    <div class=\"cardsB\" id='"+prefix+"-card-picture'>\n" +
                                    "    <div class=\"card-back\" id='"+prefix+"-card'></div>\n" +
                                    "    </div>\n" +
                                    "    </div>");

                            var leftPosition = 670+(i-1)*70;
                            var leftPositionString = leftPosition + 'px';

                            $('#'+prefix).animate({left:leftPositionString},2000,function () {

                                var currentCardPicture = $('#' + prefix + '-card-picture').attr('class');
                                $('#' + prefix + '-card-picture').removeClass(currentCardPicture);
                                $('#' + prefix + '-card-picture').addClass(dealerCardsChoose);

                                var currentCardCss = $('#'+prefix+'-card').attr('class');
                                $('#'+prefix+'-card').removeClass(currentCardCss);
                                $('#'+prefix+'-card').addClass(dealerCssName);

                                console.log(dealerCssName);

                                i = i + 1;
                                prefix = prefix + i;

                                console.log(result.dealerCard.length);
                                console.log(result);
                                if((i)<(result.dealerCard.length)){
                                    MyAnimateDealer(i,result,prefix);
                                }

                                if (i==(result.dealerCard.length)){
                                    gameover(result);

                                }

                            });

                        }





                    }
                });
            }



        });
        
        function gameover(result) {

            var bet = $('#bet').text();
            var score = $('#score').text();

            if (result.code ===2){
                //显示庄家赢
                $('.bet-score').before("<div class=\"over-word-block\" id=\"over-word-block\">\n" +
                        "            <div class=\"over-word\">\n" +
                        "                <div class=\"you-lose\"></div>\n" +
                        "            </div>\n" +
                        "        </div>");
                var temp = parseInt(score) - parseInt(bet);
                $('#score').text(temp);

            } else if(result.code==3){
                //显示闲家赢
                $('.bet-score').before("<div class=\"over-word-block\" id=\"over-word-block\">\n" +
                        "            <div class=\"over-word\">\n" +
                        "                <div class=\"you-win\"></div>\n" +
                        "            </div>\n" +
                        "        </div>");
                var temp = parseInt(score) + parseInt(bet);
                $('#score').text(temp);

            } else if(result.code==4){
                //显示平局
                $('.bet-score').before("<div class=\"over-word-block\" id=\"over-word-block\">\n" +
                        "            <div class=\"over-word\">\n" +
                        "                <div class=\"push\"></div>\n" +
                        "            </div>\n" +
                        "        </div>");

            }

            //点击之后设置透明度
            $('.button-deal').css({opacity: 1});
            $('.button-2x').css({opacity: 1});
            $('.button-stand').css({opacity: 0.5});
            $('.button-hit').css({opacity: 0.5});
            //点击之后,以下按钮都会不可点击
            $('.button-stand').css("cursor", "default");
            $('.button-hit').css("cursor", "default");
            //点击之后,以下按钮都会变成可点击的
            $('.button-deal').css("cursor", "pointer");
            $('.button-2x').css("cursor", "pointer");
            $('.button-x20').css("cursor", "pointer");
            $('.button-x100').css("cursor", "pointer");
            $('.button-x500').css("cursor", "pointer");
            $('.button-x1k').css("cursor", "pointer");



            canDeal = false;
            isBegin = false;
            canHit = false;
        }

        
        $('.button-hit').on('click',function () {
            if (isBegin&&canHit) {
                canHit = false;
                $.ajax({

                    url: '/blackjack/hit',
                    data: {
                        "sessionId": '${sessionId}',
                    },
                    type: 'get',
                    dataType: "json",
                    success: function (result) {
                        console.log(result);
                        var prefix = 'player'+ (result.position-1);

                        if (result.code == 1){

                            $('.bet-score').before("<div class=\"cardsB-block\" id='"+prefix+"'>\n" +
                                    "    <div class=\"cardsB\" id='"+prefix+"-card-picture'>\n" +
                                    "    <div class=\"card-back\" id='"+prefix+"-card'></div>\n" +
                                    "    </div>\n" +
                                    "    </div>");


                            var leftPosition = 670+(result.position-2)*70;
                            var leftPositionString = leftPosition + 'px';

                            var dealerCssName = transfer(result.card.suit, result.card.point);
                            var dealerCardsChoose = getCardsAOrCardsB(result.card.suit, result.card.point);

                            $('#'+prefix).animate({left:leftPositionString,top:'350px'},2000,function () {



                                var currentCardPicture = $('#' + prefix + '-card-picture').attr('class');
                                $('#' + prefix + '-card-picture').removeClass(currentCardPicture);
                                $('#' + prefix + '-card-picture').addClass(dealerCardsChoose);

                                var currentCardCss = $('#' + prefix + '-card').attr('class');
                                $('#' + prefix + '-card').removeClass(currentCardCss);
                                $('#' + prefix + '-card').addClass(dealerCssName);

                                canHit = true;
                            })
                        } else{
                            $('.bet-score').before("<div class=\"cardsB-block\" id='"+prefix+"'>\n" +
                                    "    <div class=\"cardsB\" id='"+prefix+"-card-picture'>\n" +
                                    "    <div class=\"card-back\" id='"+prefix+"-card'></div>\n" +
                                    "    </div>\n" +
                                    "    </div>");


                            var leftPosition = 670+(result.position-2)*70;
                            var leftPositionString = leftPosition + 'px';

                            var dealerCssName = transfer(result.card.suit, result.card.point);
                            var dealerCardsChoose = getCardsAOrCardsB(result.card.suit, result.card.point);

                            $('#'+prefix).animate({left:leftPositionString,top:'350px'},2000,function () {

                                var currentCardPicture = $('#' + prefix + '-card-picture').attr('class');
                                $('#' + prefix + '-card-picture').removeClass(currentCardPicture);
                                $('#' + prefix + '-card-picture').addClass(dealerCardsChoose);

                                var currentCardCss = $('#' + prefix + '-card').attr('class');
                                $('#' + prefix + '-card').removeClass(currentCardCss);
                                $('#' + prefix + '-card').addClass(dealerCssName);

                                var suit = jsonData.dealerCard[1].suit;
                                var point = jsonData.dealerCard[1].point;
                                var dealerCssName1 = transfer(suit, point);
                                var dealerCardsChoose1 = getCardsAOrCardsB(suit,point);
                                //翻开庄家的第二张牌
                                var currentCardPicture = $('#dealer1-card-picture').attr('class');
                                $('#dealer1-card-picture').removeClass(currentCardPicture);
                                $('#dealer1-card-picture').addClass(dealerCardsChoose1);

                                var currentCardCss = $('#dealer1-card').attr('class');
                                $('#dealer1-card').removeClass(currentCardCss);
                                $('#dealer1-card').addClass(dealerCssName1);



                                gameover(result);
                            })



                        }


                    }
                })
            }
        })


    });
</script>


<div class="game">
    <div class="background-picture">
        <img src="/blackjack/images/background.png">
        <div class="header">
            <img src="/blackjack/images/header.png">
        </div>
        <div class="score-icon">
            <img src="/blackjack/images/score.png">
        </div>

        <div class="score">
            <div class="font" id="score">5000</div>
        </div>

    <#--<div class="beat-score">-->
    <#--<div class="font">123456789</div>-->
    <#--</div>-->

    <#--<div class="beat">-->
    <#--<img src="/blackjack/images/beat.png">-->
    <#--</div>-->

        <div class="button-x20" id="button-x20">
            <img src="/blackjack/images/x20.png">
        </div>

        <div class="button-x100" id="button-x100">
            <img src="/blackjack/images/x100.png">
        </div>

        <div class="button-x500" id="button-x500">
            <img src="/blackjack/images/x500.png">
        </div>

        <div class="button-x1k" id="button-x1k">
            <img src="/blackjack/images/x1k.png">
        </div>

        <div class="deck">
            <img src="/blackjack/images/deck.png">
        </div>

        <div class="button-deal" id="deal">
            <img src="/blackjack/images/deal.png">
        </div>

        <div class="button-2x" id="button-2x">
            <img src="/blackjack/images/2x.png">
        </div>

        <div class="button-stand" id="button-stand">
            <img src="/blackjack/images/stand.png">
        </div>

        <div class="button-hit" id="button-hit">
            <img src="/blackjack/images/hit.png">
        </div>

        <div class="bet-score">
            <div class="font" id="bet">20</div>
        </div>

        <#--<div class="over-word-block" id="over-word-block">-->
            <#--<div class="over-word">-->
                <#--<div class="you-win"></div>-->
            <#--</div>-->
        <#--</div>-->
    <#--<div class="cardsA-block" id="cardsA-block">-->
    <#--<div class="cardsB">-->
    <#--<div class="card-back"></div>-->
    <#--</div>-->
    <#--</div>-->


    <#--<div class="cardsB-block">-->
    <#--<div class="cardsB">-->
    <#--<div class="card-back"></div>-->
    <#--</div>-->
    <#--</div>-->


    </div>
</div>
</body>
</html>